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
  NSRunningApplication *runningApplication = [self runningApplicationFromAppAuditToken:socketFlow.sourceAppAuditToken];

  NSString *remoteEndpoint = (socketFlow.remoteEndpoint) ? socketFlow.remoteEndpoint.description : @"";
  NSString *remoteUrl = (socketFlow.URL) ? socketFlow.URL.description : @"";
  NSString *direction = socketFlow.direction == 1 ? @"inbound" : @"outbound";
  NSString *localizedName = (runningApplication && runningApplication.localizedName) ?
    runningApplication.localizedName : @"";
  NSString *bundleIdentifier = (runningApplication && runningApplication.bundleIdentifier) ?
    runningApplication.bundleIdentifier : @"";

  return @{
    @"direction": direction,
    @"remoteEndpoint": remoteEndpoint,
    @"remoteUrl": remoteUrl,
    @"localizedName": localizedName,
    @"bundleIdentifier": bundleIdentifier,
  };
}

- (NSRunningApplication *)runningApplicationFromAppAuditToken:(NSData *)sourceAppAuditToken {
  pid_t sourceAppPID = audit_token_to_pid(*(audit_token_t*)sourceAppAuditToken.bytes);
  return [NSRunningApplication runningApplicationWithProcessIdentifier:sourceAppPID];
}

@end
