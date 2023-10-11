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
  for (FlowModel *flow in [FlowModel allInstances]) {
    [response addObject:[flow dictionaryWithValuesForKeys:flow.keys]];
    
    if (response.count >= 100) break;
  }

  return response;
}

- (FlowModel *)create:(NSDictionary *)payload
{
  FlowModel *lastFlow = [FlowModel firstInstanceOrderedBy:@"`id` DESC"];
  FlowModel *flow = [FlowModel instanceWithPrimaryKey:@(lastFlow.id + 1)];

  [flow save:^{
    flow.processId = [payload[@"processId"] unsignedIntValue];
    flow.direction = payload[@"direction"];
    flow.remoteEndpoint = payload[@"remoteEndpoint"];
    flow.remoteUrl = payload[@"remoteUrl"];
  }];
  
  return flow;
}

- (FlowModel *)update:(NSDictionary *)payload pk:(NSUInteger)pk
{
  FlowModel *flow = [FlowModel instanceWithPrimaryKey:@(pk)];

  [flow save:^{
    flow.processId = [payload[@"processId"] unsignedIntValue];
    flow.direction = payload[@"direction"];
    flow.remoteEndpoint = payload[@"remoteEndpoint"];
    flow.remoteUrl = payload[@"remoteUrl"];
  }];
  
  return flow;
}

- (NSUInteger)count
{
  return [[FlowModel firstValueFromQuery:@"SELECT COUNT(*) FROM $T"] unsignedIntValue];
}

@end
