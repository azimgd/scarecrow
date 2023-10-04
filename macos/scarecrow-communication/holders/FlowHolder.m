//
//  FlowHolder.m
//  scarecrow-network
//
//  Created by azim on 17.09.2023.
//

#import <Foundation/Foundation.h>
#import "FlowHolder.h"
#import "ProcessHolder.h"

@implementation FlowHolder

- (instancetype)init:(NEFilterFlow *)flow size:(NSNumber *)size {
  self = [super init];
  if (self) {
    _flow = [flow copy];
    _size = size;
    _date = [NSDate date];
  }
  return self;
}

- (NSDictionary *)payload
{
  NEFilterSocketFlow *socketFlow = (NEFilterSocketFlow*)_flow;

  NSString *identifier = (socketFlow.identifier) ? [socketFlow.identifier UUIDString] : @"";
  NSString *remoteEndpoint = (socketFlow.remoteEndpoint) ? socketFlow.remoteEndpoint.description : @"";
  NSString *remoteUrl = (socketFlow.URL) ? socketFlow.URL.description : @"";
  NSString *direction = socketFlow.direction == 1 ? @"inbound" : @"outbound";
  
  audit_token_t *auditToken = (audit_token_t*)socketFlow.sourceAppAuditToken.bytes;
  ProcessHolder *processHolder = [[ProcessHolder alloc] init:auditToken];
  
  NSString *localizedName = [[processHolder payload] objectForKey:@"localizedName"];
  NSString *bundleIdentifier = [[processHolder payload] objectForKey:@"bundleIdentifier"];
  NSString *icon = [[processHolder payload] objectForKey:@"icon"];

  return @{
    @"identifier": identifier,
    @"direction": direction,
    @"remoteEndpoint": remoteEndpoint,
    @"remoteUrl": remoteUrl,
    @"localizedName": localizedName,
    @"bundleIdentifier": bundleIdentifier,
    @"icon": icon,
    @"size": _size,
    @"date": _date,
  };
}

@end
