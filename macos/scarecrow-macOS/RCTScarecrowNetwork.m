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
  [defaultCenter addObserver:self selector:@selector(handleFlowRequest:) name:@"handleFlowRequest" object:nil];
  [defaultCenter addObserver:self selector:@selector(handleConnectionStart:) name:@"handleConnectionStart" object:nil];
  [defaultCenter addObserver:self selector:@selector(handleConnectionStop:) name:@"handleConnectionStop" object:nil];
  return self;
}

- (NSArray<NSString *> *)supportedEvents {
  return @[
    @"handleConnectionStart",
    @"handleConnectionStop",
    @"handleFlowRequest",
  ];
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXPORT_METHOD(handleExtensionStart:(RCTPromiseResolveBlock)resolve
error:(__unused RCTResponseSenderBlock)reject)
{
  [NetworkExtensionProvider.shared handleExtensionStart];
  resolve(@YES);
}

RCT_EXPORT_METHOD(handleExtensionStop:(RCTPromiseResolveBlock)resolve
error:(__unused RCTResponseSenderBlock)reject)
{
  [NetworkExtensionProvider.shared handleExtensionStop];
  resolve(@NO);
}

RCT_EXPORT_METHOD(handleExtensionStatusRequest:(RCTPromiseResolveBlock)resolve
error:(__unused RCTResponseSenderBlock)reject)
{
  [NetworkExtensionProvider.shared handleExtensionStatusRequest:^(BOOL status) {
    if (status && !HostCommunication.shared.connection) {
      [HostCommunication.shared handleConnectionStart];
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

RCT_EXPORT_METHOD(handleFlowRuleUpdate:(NSString *)bundleIdentifier
  payload:(BOOL)payload
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  [IndexData.shared handleFlowRuleUpdate:bundleIdentifier payload:payload];
  [HostCommunication.shared handleFlowRuleUpdate:bundleIdentifier payload:payload];
  resolve(@{});
}

RCT_EXPORT_METHOD(getRules:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  NSArray *response = [IndexData.shared getRules];
  resolve(response);
}

- (void)handleFlowRequest:(NSNotification*)sender
{
  [IndexData.shared createFlow:sender.userInfo[@"flow"] processPayload:sender.userInfo[@"process"]];
  [self sendEventWithName:@"handleFlowRequest" body:@{}];
}

- (void)handleConnectionStart:(NSNotification*)sender
{
  [HostCommunication.shared handleConnectionStart];
  [self sendEventWithName:@"handleConnectionStart" body:@{}];
}

- (void)handleConnectionStop:(NSNotification*)sender
{
  [HostCommunication.shared handleConnectionStop];
  [self sendEventWithName:@"handleConnectionStop" body:@{}];
}

@end
