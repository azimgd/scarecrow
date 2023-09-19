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

RCT_EXPORT_METHOD(isEnabled:(RCTPromiseResolveBlock)callback
error:(__unused RCTResponseSenderBlock)error)
{
  callback(NEFilterManager.sharedManager.isEnabled ? @YES : @NO);
}

- (void)handleDataFromFlowEvent:(NSNotification*)sender{
  [self saveFlow:sender.userInfo];
  [self sendEventWithName:@"handleDataFromFlowEvent" body:[self getGrouppedFlows]];
}

- (void)saveFlow:(NSDictionary *)payload
{
  Flow *flow = [Flow new];
  RLMRealm *realm = [RLMRealm defaultRealm];
  
  flow._id = [[NSUUID UUID] UUIDString];
  flow.direction = [payload objectForKey:@"direction"];
  flow.remoteEndpoint = [payload objectForKey:@"remoteEndpoint"];
  flow.remoteUrl = [payload objectForKey:@"remoteUrl"];
  flow.localizedName = [payload objectForKey:@"localizedName"];
  flow.bundleIdentifier = [payload objectForKey:@"bundleIdentifier"];
  
  [realm transactionWithBlock:^{
    [realm addObject:flow];
  }];
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

@end
