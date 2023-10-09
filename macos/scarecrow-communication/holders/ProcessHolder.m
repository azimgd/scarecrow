//
//  ProcessHolder.m
//  scarecrow
//
//  Created by azim on 04.10.2023.
//

#import <Foundation/Foundation.h>
#import "ProcessHolder.h"
#import "ProcessHelpers.h"

@implementation ProcessHolder

- (instancetype)init:(NEFilterFlow *)flow {
  self = [super init];

  if (self) {
    audit_token_t *auditToken = (audit_token_t*)flow.sourceAppAuditToken.bytes;
    pid_t auditTokenPID = audit_token_to_pid(*auditToken);

    _path = getProcessPathForPID(auditTokenPID);
    _name = getProcessNameForPID(auditTokenPID, _path);
    _bundleIdentifier = _path;
  }

  return self;
}

- (NSDictionary *)payload
{
  return @{
    @"bundleIdentifier": _bundleIdentifier ?: @"",
    @"path": _path ?: @"",
    @"name": _name ?: @"",
  };
}

@end
