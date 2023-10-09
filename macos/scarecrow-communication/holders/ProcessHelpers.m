//
//  ProcessHelpers.m
//  scarecrow-iOS
//
//  Created by azim on 09.10.2023.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "ProcessHelpers.h"

NSString *md5(NSString *inputString) {
  const char *cString = [inputString UTF8String];
  unsigned char digest[CC_MD5_DIGEST_LENGTH];
  CC_MD5(cString, (CC_LONG)strlen(cString), digest);
  
  NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
      [output appendFormat:@"%02x", digest[i]];
  }
  
  return output;
}


NSString *getProcessCurrentWorkingDirectory(pid_t processID)
{
  NSString *currentWorkingDirectory = nil;
  struct proc_vnodepathinfo vnodePathInfo = {0};
  int vnodePathStatus = -1;
  memset(&vnodePathInfo, 0x0, sizeof(vnodePathInfo));
  vnodePathStatus = proc_pidinfo(processID, PROC_PIDVNODEPATHINFO, 0, &vnodePathInfo, sizeof(vnodePathInfo));

  if (vnodePathStatus > 0) {
    currentWorkingDirectory = [NSString stringWithUTF8String:vnodePathInfo.pvi_cdir.vip_path];
  }

  return currentWorkingDirectory;
}

NSString *getProcessPathFromProc(pid_t processID) {
  char processPathBuffer[PROC_PIDPATHINFO_MAXSIZE] = {0};
  int processPathStatus = proc_pidpath(processID, processPathBuffer, sizeof(processPathBuffer));

  if (processPathStatus != 0) {
    return [NSString stringWithUTF8String:processPathBuffer];
  }

  return nil;
}

NSString *getProcessPathUsingSysctl(pid_t processID) {
  int mib[3] = {CTL_KERN, KERN_ARGMAX, processID};
  unsigned long systemMaxArgs = 0;
  size_t size = sizeof(systemMaxArgs);

  if (sysctl(mib, 3, &systemMaxArgs, &size, NULL, 0) != -1) {
    char *taskArgs = malloc(systemMaxArgs);

    if (taskArgs != NULL) {
      mib[1] = KERN_PROCARGS2;
      size = (size_t)systemMaxArgs;

      if (sysctl(mib, 3, taskArgs, &size, NULL, 0) != -1 && size > sizeof(int)) {
        int numberOfArgs;
        memcpy(&numberOfArgs, taskArgs, sizeof(numberOfArgs));
        NSString *processPath = [NSString stringWithUTF8String:taskArgs + sizeof(int)];
        free(taskArgs);
        return processPath;
      }

      free(taskArgs);
    }
  }

  return nil;
}

NSString *adjustProcessPathWithCurrentWorkingDirectory(NSString *processPath, pid_t processID) {
  if ([processPath hasPrefix:@"./"]) {
    processPath = [processPath substringFromIndex:2];
    NSString *currentWorkingDirectory = getProcessCurrentWorkingDirectory(processID);
    if (currentWorkingDirectory != nil) {
      processPath = [currentWorkingDirectory stringByAppendingPathComponent:processPath];
    }
  }

  return processPath;
}

NSBundle *findAppBundleAtPath(NSString *executablePath)
{
  NSBundle *applicationBundle = nil;
  NSString *standardizedPath = [[executablePath stringByStandardizingPath] stringByResolvingSymlinksInPath];
  NSString *searchPath = standardizedPath;

  while (searchPath && ![searchPath isEqualToString:@"/"] && ![searchPath isEqualToString:@""]) {
    applicationBundle = [NSBundle bundleWithPath:searchPath];

    if (applicationBundle) {
      if ([applicationBundle.bundlePath isEqualToString:standardizedPath] ||
        [applicationBundle.executablePath isEqualToString:standardizedPath]) {
        break;
      } else {
        applicationBundle = nil;
      }
    }

    searchPath = [searchPath stringByDeletingLastPathComponent];
  }

  return applicationBundle;
}

NSString *imageToBase64(NSImage *image)
{
  NSData* imageData = [image TIFFRepresentation];
  NSString* base64String = [imageData base64EncodedStringWithOptions:0];
  return base64String;
}

NSString *saveImage(NSImage *image, NSString *executablePath) {
  NSString *filename = [NSString stringWithFormat:@"%@.png", md5(executablePath)];
  NSString *destination = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];

  if ([[NSFileManager defaultManager] fileExistsAtPath:destination]) {
    return destination;
  }

  NSData *imageData = [image TIFFRepresentation];
  NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
  NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.9] forKey:NSImageCompressionFactor];
  imageData = [imageRep representationUsingType:NSPNGFileType properties:imageProps];
  [imageData writeToFile:destination atomically:NO];

  return destination;
}

NSString *getProcessNameForPID(pid_t processID, NSString *executablePath) {
  NSString *processName = nil;
  int processNameStatus = -1;
  char processNameBuffer[PROC_PIDPATHINFO_MAXSIZE] = {0};
  memset(processNameBuffer, 0x0, sizeof(processNameBuffer));

  if (processID != 0) {
    processNameStatus = proc_name(processID, &processNameBuffer, sizeof(processNameBuffer));
    if (processNameStatus >= 0) {
      processName = [NSString stringWithUTF8String:processNameBuffer];
    }
  }

  if (processName == nil) {
    NSBundle *applicationBundle = findAppBundleAtPath(executablePath);
    if (applicationBundle != nil) {
      processName = applicationBundle.infoDictionary[@"CFBundleName"];
    }
  }

  if (processName == nil) {
    processName = [executablePath lastPathComponent];
  }

  return processName;
}

NSString *getIconForExecutablePath(NSString *executablePath)
{
  NSString* iconFile = nil;
  NSString* iconPath = nil;
  NSString* iconExtension = nil;
  NSImage* icon = nil;
  static NSImage* documentIcon = nil;
  NSBundle* processBundle = nil;
  
  if (YES != [[NSFileManager defaultManager] fileExistsAtPath:executablePath]) {
    icon = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericApplicationIcon)];
    [icon setSize:NSMakeSize(32, 32)];
  } else {
    processBundle = findAppBundleAtPath(executablePath);
      
    if (processBundle != nil) {
      iconFile = processBundle.infoDictionary[@"CFBundleIconFile"];
      iconExtension = [iconFile pathExtension];
      
      if ([iconExtension isEqualTo:@""]) {
        iconExtension = @"icns";
      }
      
      iconPath = [processBundle pathForResource:[iconFile stringByDeletingPathExtension] ofType:iconExtension];
      icon = [[NSImage alloc] initWithContentsOfFile:iconPath];
    }
    
    if ((processBundle == nil) || (icon == nil)) {
      icon = [[NSWorkspace sharedWorkspace] iconForFile:executablePath];
      
      if (documentIcon == nil) {
        documentIcon = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericDocumentIcon)];
      }
      
      if ([icon isEqual:documentIcon]) {
        icon = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericApplicationIcon)];
      }

      [icon setSize:NSMakeSize(32, 32)];
    }
  }

  return saveImage(icon, executablePath);
}

NSString *getProcessPathForPID(pid_t processID) {
  NSString *processPath = getProcessPathFromProc(processID);

  if (processPath == nil) {
    processPath = getProcessPathUsingSysctl(processID);
    if (processPath != nil) {
      processPath = adjustProcessPathWithCurrentWorkingDirectory(processPath, processID);
    }
  }

  return processPath;
}
