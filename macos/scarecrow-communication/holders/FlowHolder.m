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

- (instancetype)init:(NEFilterFlow *)flow {
  self = [super init];

  if (self) {
    NEFilterSocketFlow *socketFlow = (NEFilterSocketFlow*)flow;
    _identifier = (socketFlow.identifier) ? [socketFlow.identifier UUIDString] : @"";
    _remoteEndpoint = (socketFlow.remoteEndpoint) ? socketFlow.remoteEndpoint.description : @"";
    _remoteUrl = (socketFlow.URL) ? socketFlow.URL.description : @"";
    _direction = socketFlow.direction == 1 ? @"inbound" : @"outbound";
  }

  return self;
}

- (NSDictionary *)payload
{
  return @{
    @"identifier": _identifier,
    @"direction": _direction,
    @"remoteEndpoint": _remoteEndpoint,
    @"remoteUrl": _remoteUrl,
  };
}

@end
