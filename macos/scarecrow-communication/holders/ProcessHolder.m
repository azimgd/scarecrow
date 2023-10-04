//
//  ProcessHolder.m
//  scarecrow
//
//  Created by azim on 04.10.2023.
//

#import <Foundation/Foundation.h>
#import "ProcessHolder.h"

@implementation ProcessHolder

- (instancetype)init:(audit_token_t *)auditToken {
  self = [super init];

  if (self) {
    _path = [self getProcessPathForPID:audit_token_to_pid(*auditToken)];
    _name = [self getProcessNameForPID:audit_token_to_pid(*auditToken) executablePath:_path];
  }

  return self;
}

- (NSDictionary *)payload
{
  return @{
    @"bundleIdentifier": _path ?: @"",
    @"localizedName": _name ?: @"",
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


@end
