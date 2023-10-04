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
    _runningApplication = [self runningApplicationFromAppAuditToken:auditToken];
  }

  return self;
}

- (NSDictionary *)payload
{
  return @{
    @"bundleIdentifier": _runningApplication.bundleIdentifier ?: @"",
    @"localizedName": _runningApplication.localizedName ?: @"",
  };
}

- (NSRunningApplication *)runningApplicationFromAppAuditToken:(audit_token_t *)auditToken {
  pid_t sourceAppPID = audit_token_to_pid(*auditToken);
  return [NSRunningApplication runningApplicationWithProcessIdentifier:sourceAppPID];
}

@end
