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
#import "Rule.h"

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
  resolve([self getGrouppedFlows]);
}

RCT_EXPORT_METHOD(getFlowsByBundleIdentifier:(NSString *)bundleIdentifier
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  resolve([self getFlowsByBundleIdentifier:bundleIdentifier]);
}

- (void)handleDataFromFlowEvent:(NSNotification*)sender{
  [self sendEventWithName:@"handleDataFromFlowEvent" body:@{}];
}

- (NSDictionary *)getGrouppedFlows
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults<Flow *> *results = [Flow allObjectsInRealm:realm];
  RLMResults<Flow *> *distinctResults = [results distinctResultsUsingKeyPaths:@[@"bundleIdentifier"]];
  
  NSMutableDictionary *response = [NSMutableDictionary new];
  for (Flow *item in distinctResults) {
    response[item.bundleIdentifier] = [item payload];
  }
  
  return response;
}

- (NSArray *)getFlowsByBundleIdentifier:(NSString *)bundleIdentifier
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults<Flow *> *results = [Flow allObjectsInRealm:realm];
  RLMResults<Flow *> *distinctResults = [results objectsWithPredicate:[NSPredicate predicateWithFormat:@"bundleIdentifier == %@", bundleIdentifier]];
  
  NSMutableArray *response = [NSMutableArray new];
  for (NSInteger offset = 0; offset < 10; offset++) {
    Flow *item = distinctResults[offset];
    [response addObject:[item payload]];
  }
  
  return response;
}

@end
