//
//  RCTScarecrowNetwork.m
//  scarecrow-macOS
//
//  Created by azim on 15.09.2023.
//

#import <Foundation/Foundation.h>
#import "RCTScarecrowNetwork.h"
#import "HostCommunication.h"
#import "Migrations.h"
#import "FlowController.h"
#import "ProcessController.h"
#import "RuleController.h"

@implementation RCTScarecrowNetwork

RCT_EXPORT_MODULE();

- (instancetype)init
{
  self = [super init];
  
  [Migrations new];
  
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

RCT_EXPORT_METHOD(getProcesses:(NSString *)filter
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  ProcessController *processController = [ProcessController new];
  NSArray *response = [processController get];
  resolve(response);
}

RCT_EXPORT_METHOD(countProcesses:(NSString *)filter
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  ProcessController *processController = [ProcessController new];
  NSUInteger response = [processController count];
  resolve(@(response));
}

RCT_EXPORT_METHOD(getFlows:(NSString *)filter
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  FlowController *flowController = [FlowController new];
  NSArray *response = [flowController get];
  resolve(response);
}

RCT_EXPORT_METHOD(countFlows:(NSString *)filter
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  FlowController *flowController = [FlowController new];
  NSUInteger response = [flowController count];
  resolve(@(response));
}

RCT_EXPORT_METHOD(handleFlowRuleUpdate:(NSString *)bundleIdentifier
  payload:(BOOL)payload
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  // [IndexData.shared handleFlowRuleUpdate:bundleIdentifier payload:payload];
  [HostCommunication.shared handleFlowRuleUpdate:bundleIdentifier payload:payload];
  resolve(@{});
}

RCT_EXPORT_METHOD(getRules:(NSString *)filter
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  RuleController *ruleController = [RuleController new];
  NSArray *response = [ruleController get];
  resolve(response);
}

RCT_EXPORT_METHOD(countRules:(NSString *)filter
  resolve:(RCTPromiseResolveBlock)resolve
  error:(__unused RCTResponseSenderBlock)reject)
{
  RuleController *ruleController = [RuleController new];
  NSUInteger response = [ruleController count];
  resolve(@(response));
}

- (void)handleFlowRequest:(NSNotification*)sender
{
  ProcessController *processController = [ProcessController new];
  ProcessModel *process = [processController create:@{
    @"bundle": sender.userInfo[@"process"][@"bundle"],
    @"path": sender.userInfo[@"process"][@"path"],
    @"name": sender.userInfo[@"process"][@"name"],
    @"icon": sender.userInfo[@"process"][@"icon"],
  }];
  
  RuleController *ruleController = [RuleController new];
  [ruleController create:@{
    @"processId": @(process.id),
    @"allowed": @YES,
  }];
  
  FlowController *flowController = [FlowController new];
  [flowController create:@{
    @"processId": @(process.id),
    @"identifier": sender.userInfo[@"flow"][@"identifier"],
    @"direction": sender.userInfo[@"flow"][@"direction"],
    @"remoteEndpoint": sender.userInfo[@"flow"][@"remoteEndpoint"],
    @"remoteUrl": sender.userInfo[@"flow"][@"remoteUrl"],
    @"size": sender.userInfo[@"flow"][@"size"],
  }];
  
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
