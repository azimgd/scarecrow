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
  return @[@"handleDataFromFlowEvent"];
}

RCT_EXPORT_METHOD(enable)
{
  [[NetworkExtensionProvider shared] enable];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDataFromFlowEvent:) name:@"handleDataFromFlowEvent" object:nil];
}

RCT_EXPORT_METHOD(disable)
{
  [[NetworkExtensionProvider shared] disable];
}

- (void)handleDataFromFlowEvent:(NSNotification*)sender{
  [self sendEventWithName:@"handleDataFromFlowEvent" body:sender.userInfo];
}

@end
