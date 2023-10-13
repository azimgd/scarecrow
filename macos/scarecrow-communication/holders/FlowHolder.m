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

- (instancetype)init:(NEFilterFlow *)flow size:(int)size {
  self = [super init];

  if (self) {
    NEFilterSocketFlow *socketFlow = (NEFilterSocketFlow*)flow;
    _identifier = (socketFlow.identifier) ? [socketFlow.identifier UUIDString] : @"";
    _remoteEndpoint = (socketFlow.remoteEndpoint) ? socketFlow.remoteEndpoint.description : @"";
    _remoteUrl = (socketFlow.URL) ? socketFlow.URL.description : @"";
    _direction = (int)socketFlow.direction;
    _socketFamily = socketFlow.socketFamily;
    _socketType = socketFlow.socketType;
    _socketProtocol = socketFlow.socketProtocol;
    _size = size ?: 0;
  }

  return self;
}

- (NSDictionary *)payload
{
  return @{
    @"identifier": _identifier,
    @"direction": @(_direction),
    @"socketFamily": @(_socketFamily),
    @"socketType": @(_socketType),
    @"socketProtocol": @(_socketProtocol),
    @"remoteEndpoint": _remoteEndpoint,
    @"remoteUrl": _remoteUrl,
    @"size": @(_size),
  };
}

@end
