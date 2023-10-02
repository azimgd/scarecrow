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
#import "Flow.h"

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

RCT_EXPORT_METHOD(getGrouppedFlowsByBundleIdentifier:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *flows = [Flow allObjectsInRealm:realm];
  RLMResults *distinctFlows = [flows distinctResultsUsingKeyPaths:@[@"bundleIdentifier"]];

  NSMutableArray *response = [NSMutableArray array];
  for (Flow *flow in distinctFlows) {
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:[flow dictionaryWithValuesForKeys:@[
      @"direction",
      @"remoteEndpoint",
      @"remoteUrl",
      @"localizedName",
      @"bundleIdentifier",
      @"size",
      @"date",
    ]]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    item[@"date"] = [dateFormat stringFromDate:item[@"date"]];

    RLMResults *flows = [Flow objectsInRealm:realm withPredicate:[NSPredicate predicateWithFormat:@"bundleIdentifier = %@", flow.bundleIdentifier]];
    item[@"totalSize"] = [flows sumOfProperty:@"size"];
    item[@"totalCount"] = @([flows count]);

    [response addObject:item];
  }
    
  resolve(response);
}

RCT_EXPORT_METHOD(getGrouppedFlowsByRemoteEndpoint:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *flows = [Flow allObjectsInRealm:realm];
  RLMResults *distinctFlows = [flows distinctResultsUsingKeyPaths:@[@"remoteEndpoint"]];

  NSLog(@"wiwi 99 %@", distinctFlows);

  NSMutableArray *response = [NSMutableArray array];
  for (Flow *flow in distinctFlows) {
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:[flow dictionaryWithValuesForKeys:@[
      @"direction",
      @"remoteEndpoint",
      @"remoteUrl",
      @"localizedName",
      @"bundleIdentifier",
      @"size",
      @"date",
    ]]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    item[@"date"] = [dateFormat stringFromDate:item[@"date"]];

    RLMResults *flows = [Flow objectsInRealm:realm withPredicate:[NSPredicate predicateWithFormat:@"remoteEndpoint = %@", flow.bundleIdentifier]];
    item[@"totalSize"] = [flows sumOfProperty:@"size"];
    item[@"totalCount"] = @([flows count]);

    [response addObject:item];
  }
    
  resolve(response);
}

RCT_EXPORT_METHOD(getFlowsByBundleIdentifier:(NSString *)bundleIdentifier
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *flows = [Flow objectsInRealm:realm withPredicate:[NSPredicate predicateWithFormat:@"bundleIdentifier = %@", bundleIdentifier]];

  NSMutableArray *response = [NSMutableArray array];
  for (Flow *flow in flows) {
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:[flow dictionaryWithValuesForKeys:@[
      @"direction",
      @"remoteEndpoint",
      @"remoteUrl",
      @"localizedName",
      @"bundleIdentifier",
      @"size",
      @"date",
    ]]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    item[@"date"] = [dateFormat stringFromDate:item[@"date"]];
    
    [response addObject:item];
  }

  resolve(response);
}

RCT_EXPORT_METHOD(getFlowsByRemoteEndpoint:(NSString *)remoteEndpoint
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *flows = [Flow objectsInRealm:realm withPredicate:[NSPredicate predicateWithFormat:@"remoteEndpoint = %@", remoteEndpoint]];

  NSMutableArray *response = [NSMutableArray array];
  for (Flow *flow in flows) {
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:[flow dictionaryWithValuesForKeys:@[
      @"direction",
      @"remoteEndpoint",
      @"remoteUrl",
      @"localizedName",
      @"bundleIdentifier",
      @"size",
      @"date",
    ]]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    item[@"date"] = [dateFormat stringFromDate:item[@"date"]];
    
    [response addObject:item];
  }

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
//  [self sendEventWithName:@"handleDataFromFlowEvent" body:@{}];
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
