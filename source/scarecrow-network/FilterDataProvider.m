//
//  FilterDataProvider.m
//  scarecrow-filter-data
//
//  Created by azim on 11.09.2023.
//

#import "FilterDataProvider.h"
#import "ExtensionCommunication.h"
#import <os/log.h>

@implementation FilterDataProvider

- (void)startFilterWithCompletionHandler:(void (^)(NSError *error))completionHandler {
  os_log(OS_LOG_DEFAULT, "[scarecrow-filter] startFilterWithCompletionHandler");

  NWHostEndpoint *remoteNetwork = [NWHostEndpoint endpointWithHostname:@"0.0.0.0" port:@"443"];

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

  NEFilterSocketFlow *socketFlow = (NEFilterSocketFlow*)flow;
  NWHostEndpoint *remoteEndpoint = (NWHostEndpoint*)socketFlow.remoteEndpoint;

  NSString *payload = [NSString stringWithFormat:@"inbound: %@ / url: %@", remoteEndpoint, flow.URL];

  NSXPCConnection *connection = [ExtensionCommunication shared].connection;
  [[connection remoteObjectProxy] logger:payload];

  return [NEFilterDataVerdict allowVerdict];
}

- (NEFilterDataVerdict *)handleOutboundDataFromFlow:(NEFilterFlow *)flow readBytesStartOffset:(NSUInteger)offset readBytes:(NSData *)readBytes {
  os_log(OS_LOG_DEFAULT, "[scarecrow-filter] handleOutboundDataFromFlow");
  
  NEFilterSocketFlow *socketFlow = (NEFilterSocketFlow*)flow;
  NWHostEndpoint *remoteEndpoint = (NWHostEndpoint*)socketFlow.remoteEndpoint;

  NSString *payload = [NSString stringWithFormat:@"outbound: %@ / url: %@", remoteEndpoint, flow.URL];

  NSXPCConnection *connection = [ExtensionCommunication shared].connection;
  [[connection remoteObjectProxy] logger:payload];
  
  return [NEFilterDataVerdict allowVerdict];
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
