//
//  ProcessHolder.m
//  scarecrow
//
//  Created by azim on 04.10.2023.
//

#import <Foundation/Foundation.h>
#import "ProcessHolder.h"

@implementation ProcessHolder

- (instancetype)init:(NEFilterFlow *)flow {
  self = [super init];

  if (self) {
    audit_token_t *auditToken = (audit_token_t*)flow.sourceAppAuditToken.bytes;
    pid_t auditTokenPID = audit_token_to_pid(*auditToken);

    _path = [self getProcessPathForPID:auditTokenPID];
    _name = [self getProcessNameForPID:auditTokenPID executablePath:_path];
//    _icon = [self getIconForExecutablePath:_path];

    _localizedName = _name;
    _bundleIdentifier = _name;
  }

  return self;
}

- (NSDictionary *)payload
{
  return @{
    @"bundleIdentifier": _bundleIdentifier ?: @"",
    @"localizedName": _localizedName ?: @"",
    @"path": _path ?: @"",
    @"name": _name ?: @"",
    @"icon": _icon ?: @"",
  };
}

- (NSString *)getProcessPathForPID:(pid_t)processID {
  NSString *processPath = getProcessPathFromProc(processID);

  if (processPath == nil) {
    processPath = getProcessPathUsingSysctl(processID);
    if (processPath != nil) {
      processPath = adjustProcessPathWithCurrentWorkingDirectory(processPath, processID);
    }
  }

  return processPath;
}

- (NSString *)getProcessNameForPID:(pid_t)processID executablePath:(NSString *)executablePath
{
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

NSString* imageToBase64(NSImage *image)
{
  NSData* imageData = [image TIFFRepresentation];
  NSString* base64String = [imageData base64EncodedStringWithOptions:0];
  return base64String;
}

- (NSString *)getIconForExecutablePath:(NSString *)executablePath
{
  NSString* iconFile = nil;
  NSString* iconPath = nil;
  NSString* iconExtension = nil;
  NSImage* icon = nil;
  static NSImage* documentIcon = nil;
  NSBundle* processBundle = nil;
  
  if (YES != [[NSFileManager defaultManager] fileExistsAtPath:executablePath]) {
    icon = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericApplicationIcon)];
    [icon setSize:NSMakeSize(128, 128)];
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

      [icon setSize:NSMakeSize(128, 128)];
    }
  }

  return imageToBase64(icon);
}


@end
