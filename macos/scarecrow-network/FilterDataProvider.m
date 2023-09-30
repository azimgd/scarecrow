//
//  FilterDataProvider.m
//  scarecrow-network
//
//  Created by azim on 11.09.2023.
//

#import "FilterDataProvider.h"
#import "ExtensionCommunication.h"
#import "FlowEntry.h"
#import "Validator.h"
#import <os/log.h>

@implementation FilterDataProvider

- (void)startFilterWithCompletionHandler:(void (^)(NSError *error))completionHandler {
  os_log(OS_LOG_DEFAULT, "[scarecrow-filter] startFilterWithCompletionHandler");

  NWHostEndpoint *remoteNetwork = [NWHostEndpoint endpointWithHostname:@"0.0.0.0" port:@""];

  NENetworkRule* networkRule = [
    [NENetworkRule alloc]
    initWithRemoteNetwork:remoteNetwork
    remotePrefix:0
    localNetwork:nil
    localPrefix:0
    protocol:NENetworkRuleProtocolAny
    direction:NETrafficDirectionOutbound
  ];

  NEFilterRule* filterRule = [
    [NEFilterRule alloc]
    initWithNetworkRule:networkRule
    action:NEFilterActionFilterData
  ];

  NEFilterSettings* filterSettings = [  
    [NEFilterSettings alloc]
    initWithRules:@[filterRule]
    defaultAction:NEFilterActionAllow
  ];

  [self applySettings:filterSettings completionHandler:^(NSError * _Nullable error) {
    completionHandler(error);
  }];
}

- (void)stopFilterWithReason:(NEProviderStopReason)reason completionHandler:(void (^)(void))completionHandler {
  completionHandler();
}

- (NEFilterNewFlowVerdict *)handleNewFlow:(NEFilterFlow *)flow {
  return [NEFilterNewFlowVerdict
    filterDataVerdictWithFilterInbound:true
    peekInboundBytes:NEFilterFlowBytesMax
    filterOutbound:true
    peekOutboundBytes:NEFilterFlowBytesMax];
}

- (NEFilterDataVerdict *)handleInboundDataFromFlow:(NEFilterFlow *)flow readBytesStartOffset:(NSUInteger)offset readBytes:(NSData *)readBytes {
  os_log(OS_LOG_DEFAULT, "[scarecrow-filter] handleInboundDataFromFlow");

  FlowEntry *flowEntry = [[FlowEntry alloc] initWithFlow:flow];

  NSXPCConnection *connection = [ExtensionCommunication shared].connection;
  [[connection remoteObjectProxy] handleDataFromFlowEvent:flowEntry.payload];
  
  NEFilterDataVerdict *verdict;

  NSString *bundleIdentifier = [[flowEntry payload] objectForKey:@"bundleIdentifier"];
  if (Validator.shared.rules[bundleIdentifier] == nil) {
    verdict = [NEFilterDataVerdict allowVerdict];
  } else if ([Validator.shared.rules[bundleIdentifier] boolValue]) {
    verdict = [NEFilterDataVerdict allowVerdict];
  } else {
    verdict = [NEFilterDataVerdict dropVerdict];
  }

  return verdict;
}

- (NEFilterDataVerdict *)handleOutboundDataFromFlow:(NEFilterFlow *)flow readBytesStartOffset:(NSUInteger)offset readBytes:(NSData *)readBytes {
  os_log(OS_LOG_DEFAULT, "[scarecrow-filter] handleOutboundDataFromFlow");
  
  FlowEntry *flowEntry = [[FlowEntry alloc] initWithFlow:flow];

  NSXPCConnection *connection = [ExtensionCommunication shared].connection;
  [[connection remoteObjectProxy] handleDataFromFlowEvent:flowEntry.payload];
  
  NEFilterDataVerdict *verdict;

  NSString *bundleIdentifier = [[flowEntry payload] objectForKey:@"bundleIdentifier"];
  if (Validator.shared.rules[bundleIdentifier] == nil) {
    verdict = [NEFilterDataVerdict allowVerdict];
  } else if ([Validator.shared.rules[bundleIdentifier] boolValue]) {
    verdict = [NEFilterDataVerdict allowVerdict];
  } else {
    verdict = [NEFilterDataVerdict dropVerdict];
  }
  
  return verdict;
}

- (NEFilterDataVerdict *)handleInboundDataCompleteForFlow:(NEFilterFlow *)flow {
  os_log(OS_LOG_DEFAULT, "[scarecrow-filter] handleInboundDataCompleteForFlow");

  return [NEFilterDataVerdict allowVerdict];
}

- (NEFilterDataVerdict *)handleOutboundDataCompleteForFlow:(NEFilterFlow *)flow {
  os_log(OS_LOG_DEFAULT, "[scarecrow-filter] handleOutboundDataCompleteForFlow");

  return [NEFilterDataVerdict allowVerdict];
}

@end
