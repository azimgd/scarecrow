//
//  RCTScarecrowNetwork.m
//  scarecrow-macOS
//
//  Created by azim on 15.09.2023.
//

#import <Foundation/Foundation.h>
#import "RCTScarecrowNetwork.h"
#import "HostCommunication.h"
#import <NetworkExtension/NetworkExtension.h>

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

RCT_EXPORT_METHOD(isEnabled:(RCTPromiseResolveBlock)resolve
error:(__unused RCTResponseSenderBlock)reject)
{
  resolve(NEFilterManager.sharedManager.isEnabled ? @YES : @NO);
}

RCT_EXPORT_METHOD(getGrouppedFlows:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  resolve(@{});
}

RCT_EXPORT_METHOD(getFlowsByBundleIdentifier:(NSString *)bundleIdentifier
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  resolve(@[]);
}

RCT_EXPORT_METHOD(toggleFlowRule:(NSString *)bundleIdentifier
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  [[HostCommunication shared] toggleFlowRule:bundleIdentifier withCallback:^(BOOL status) {
    resolve(@{});
  }];
}

- (void)handleDataFromFlowEvent:(NSNotification*)sender{
  [self sendEventWithName:@"handleDataFromFlowEvent" body:@{}];
}

@end
