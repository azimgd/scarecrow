//
//  FlowController.m
//  scarecrow-macOS
//
//  Created by azim on 11.10.2023.
//

#import <Foundation/Foundation.h>
#import "FlowController.h"

@implementation FlowController

- (NSArray *)get
{
  NSMutableArray *response = [NSMutableArray new];
  for (FlowModel *flow in [FlowModel instancesOrderedBy:@"`createdAt` DESC LIMIT 5"]) {
    [response addObject:[flow dictionaryWithValuesForKeys:flow.keys]];
  }

  return response;
}

- (FlowModel *)create:(NSDictionary *)payload
{
  FlowModel *lastFlow = [FlowModel firstInstanceOrderedBy:@"`id` DESC"];
  FlowModel *flow = [FlowModel instanceWithPrimaryKey:@(lastFlow.id + 1)];

  [flow save:^{
    flow.processId = [payload[@"processId"] unsignedIntValue];
    flow.identifier = payload[@"identifier"];
    flow.direction = payload[@"direction"];
    flow.remoteEndpoint = payload[@"remoteEndpoint"];
    flow.remoteUrl = payload[@"remoteUrl"];
    flow.size = [payload[@"size"] intValue];
  }];
  
  return flow;
}

- (FlowModel *)update:(NSDictionary *)payload pk:(NSUInteger)pk
{
  FlowModel *flow = [FlowModel instanceWithPrimaryKey:@(pk)];

  [flow save:^{
    flow.processId = [payload[@"processId"] unsignedIntValue];
    flow.identifier = payload[@"identifier"];
    flow.direction = payload[@"direction"];
    flow.remoteEndpoint = payload[@"remoteEndpoint"];
    flow.remoteUrl = payload[@"remoteUrl"];
    flow.size = [payload[@"size"] intValue];
  }];
  
  return flow;
}

- (NSUInteger)count
{
  return [[FlowModel firstValueFromQuery:@"SELECT COUNT(*) FROM $T"] unsignedIntValue];
}

@end
