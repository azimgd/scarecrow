//
//  ProcessHelpers.h
//  scarecrow
//
//  Created by azim on 09.10.2023.
//

#ifndef ProcessHelpers_h
#define ProcessHelpers_h

#import <AppKit/AppKit.h>
#import <bsm/libbsm.h>
#import <libproc.h>
#import <sys/sysctl.h>

NSString *getProcessCurrentWorkingDirectory(pid_t processID);
NSString *getProcessPathFromProc(pid_t processID);
NSString *getProcessPathUsingSysctl(pid_t processID);
NSString *adjustProcessPathWithCurrentWorkingDirectory(NSString *processPath, pid_t processID);
NSBundle *findAppBundleAtPath(NSString *executablePath);
NSString *imageToBase64(NSImage *image);
NSString *getProcessNameForPID(pid_t processID, NSString *executablePath);
NSString *getIconForExecutablePath(NSString *executablePath);
NSString *getProcessPathForPID(pid_t processID);

#endif /* ProcessHelpers_h */
