//
//  FlowEntry.m
//  scarecrow-network
//
//  Created by azim on 17.09.2023.
//

#import <Foundation/Foundation.h>
#import "FlowEntry.h"

@implementation FlowEntry

- (instancetype)initWithFlow:(NEFilterFlow *)flow {
  self = [super init];
  if (self) {
    _flow = [flow copy];
  }
  return self;
}

- (NSDictionary *)payload
{
  NEFilterSocketFlow *socketFlow = (NEFilterSocketFlow*)_flow;
  NWHostEndpoint *remoteEndpoint = (NWHostEndpoint*)socketFlow.remoteEndpoint;
  NSRunningApplication *runningApplication = [self runningApplicationFromAppAuditToken:socketFlow.sourceAppAuditToken];

  NSString *direction = socketFlow.direction == 1 ? @"inbound" : @"outbound";
  NSString *localizedName = (runningApplication != nil && runningApplication.localizedName != nil) ?
    runningApplication.localizedName : @"";
  NSString *bundleIdentifier = (runningApplication != nil && runningApplication.bundleIdentifier != nil) ?
    runningApplication.bundleIdentifier : @"";

  return @{
    @"direction": direction,
    @"remoteEndpoint": remoteEndpoint.description,
    @"url": socketFlow.URL.description,
    @"localizedName": localizedName,
    @"bundleIdentifier": bundleIdentifier,
  };
}

- (NSRunningApplication *)runningApplicationFromAppAuditToken:(NSData *)sourceAppAuditToken {
  pid_t sourceAppPID = audit_token_to_pid(*(audit_token_t*)sourceAppAuditToken.bytes);
  return [NSRunningApplication runningApplicationWithProcessIdentifier:sourceAppPID];
}

@end
