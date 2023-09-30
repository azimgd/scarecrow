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

- (instancetype)init
{
  self = [super init];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDataFromFlowEvent:) name:@"handleDataFromFlowEvent" object:nil];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startConnection:) name:@"startConnection" object:nil];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopConnection:) name:@"stopConnection" object:nil];
  return self;
}

- (NSArray<NSString *> *)supportedEvents {
  return @[
    @"startConnection",
    @"stopConnection",
    @"handleDataFromFlowEvent",
  ];
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXPORT_METHOD(activate:(RCTPromiseResolveBlock)resolve
error:(__unused RCTResponseSenderBlock)reject)
{
  [[NetworkExtensionProvider shared] activate];
  resolve(@YES);
}

RCT_EXPORT_METHOD(deactivate:(RCTPromiseResolveBlock)resolve
error:(__unused RCTResponseSenderBlock)reject)
{
  [[NetworkExtensionProvider shared] deactivate];
  resolve(@NO);
}

RCT_EXPORT_METHOD(getStatus:(RCTPromiseResolveBlock)resolve
error:(__unused RCTResponseSenderBlock)reject)
{
  [[NetworkExtensionProvider shared] status:^(BOOL status) {
    if (status && ![HostCommunication shared].connection) {
      [HostCommunication shared].delegate = [HostCommunicationDelegate shared];
      [[HostCommunication shared] startConnection];
    }
  
    resolve(@(status));
  }];
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
  [[HostCommunication shared] toggleFlowRule:bundleIdentifier];
  resolve(@{});
}

- (void)handleDataFromFlowEvent:(NSNotification*)sender{
  [self sendEventWithName:@"handleDataFromFlowEvent" body:@{}];
}

- (void)startConnection:(NSNotification*)sender{
  [HostCommunication shared].delegate = [HostCommunicationDelegate shared];
  [[HostCommunication shared] startConnection];
  [self sendEventWithName:@"startConnection" body:@{}];
}

- (void)stopConnection:(NSNotification*)sender{
  [HostCommunication shared].delegate = [HostCommunicationDelegate shared];
  [[HostCommunication shared] stopConnection];

  [self sendEventWithName:@"stopConnection" body:@{}];
}

@end
