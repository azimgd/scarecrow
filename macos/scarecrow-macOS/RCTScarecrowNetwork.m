//
//  RCTScarecrowNetwork.m
//  scarecrow-macOS
//
//  Created by azim on 15.09.2023.
//

#import <Foundation/Foundation.h>
#import "RCTScarecrowNetwork.h"
#import "HostCommunication.h"
#import "IndexData.h"

@implementation RCTScarecrowNetwork

RCT_EXPORT_MODULE();

- (instancetype)init
{
  self = [super init];
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter addObserver:self selector:@selector(handleDataFromFlowEvent:) name:@"handleDataFromFlowEvent" object:nil];
  [defaultCenter addObserver:self selector:@selector(startConnection:) name:@"startConnection" object:nil];
  [defaultCenter addObserver:self selector:@selector(stopConnection:) name:@"stopConnection" object:nil];
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
      [[HostCommunication shared] startConnection];
    }
  
    resolve(@(status));
  }];
}

RCT_EXPORT_METHOD(getGrouppedFlowsByBundleIdentifier:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  NSArray *groupKeys = @[@"bundleIdentifier"];
  NSArray *response = [IndexData.shared getFlowsWithGroupKeys:groupKeys];
  resolve(response);
}

RCT_EXPORT_METHOD(countGrouppedFlowsByBundleIdentifier:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  NSArray *groupKeys = @[@"bundleIdentifier"];
  NSNumber *response = [IndexData.shared countFlowsWithGroupKeys:groupKeys];
  resolve(response);
}

RCT_EXPORT_METHOD(getGrouppedFlowsByRemoteEndpoint:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  NSArray *groupKeys = @[@"remoteEndpoint"];
  NSArray *response = [IndexData.shared getFlowsWithGroupKeys:groupKeys];
  resolve(response);
}

RCT_EXPORT_METHOD(countGrouppedFlowsByRemoteEndpoint:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  NSArray *groupKeys = @[@"remoteEndpoint"];
  NSNumber *response = [IndexData.shared countFlowsWithGroupKeys:groupKeys];
  resolve(response);
}

RCT_EXPORT_METHOD(getFlowsByBundleIdentifier:(NSString *)bundleIdentifier
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bundleIdentifier = %@", bundleIdentifier];
  NSArray *response = [IndexData.shared getFlowsWithPredicate:predicate];
  resolve(response);
}

RCT_EXPORT_METHOD(getFlowsByRemoteEndpoint:(NSString *)remoteEndpoint
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remoteEndpoint = %@", remoteEndpoint];
  NSArray *response = [IndexData.shared getFlowsWithPredicate:predicate];
  resolve(response);
}

RCT_EXPORT_METHOD(toggleFlowRule:(NSString *)bundleIdentifier
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  [[HostCommunication shared] toggleFlowRule:bundleIdentifier];
  resolve(@{});
}

- (void)handleDataFromFlowEvent:(NSNotification*)sender{
  [IndexData.shared createFlow:sender.userInfo];
  [self sendEventWithName:@"handleDataFromFlowEvent" body:@{}];
}

- (void)startConnection:(NSNotification*)sender{
  [[HostCommunication shared] startConnection];
  [self sendEventWithName:@"startConnection" body:@{}];
}

- (void)stopConnection:(NSNotification*)sender{
  [[HostCommunication shared] stopConnection];
  [self sendEventWithName:@"stopConnection" body:@{}];
}

@end
