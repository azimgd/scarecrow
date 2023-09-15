//
//  RCTScarecrowNetwork.m
//  scarecrow-macOS
//
//  Created by azim on 15.09.2023.
//

#import <Foundation/Foundation.h>
#import "RCTScarecrowNetwork.h"
#import "HostCommunication.h"

@implementation RCTScarecrowNetwork

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
  return @[@"logger"];
}

RCT_EXPORT_METHOD(enable)
{
  [[NetworkExtensionProvider shared] enable];
  [HostCommunication shared].loggerCallback = ^(NSString *payload) {
    [self sendEventWithName:@"logger" body:payload];
  };
}

RCT_EXPORT_METHOD(disable)
{
  [[NetworkExtensionProvider shared] disable];
}

@end
