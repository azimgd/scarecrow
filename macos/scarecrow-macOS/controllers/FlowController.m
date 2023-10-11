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
  }

  return response;
}

- (void)create:(NSDictionary *)payload
{
  FlowModel *lastFlow = [FlowModel firstInstanceOrderedBy:@"`id` DESC"];
  FlowModel *flow = [FlowModel instanceWithPrimaryKey:@(lastFlow.id + 1)];

  [flow save:^{
    flow.direction = payload[@"direction"];
    flow.remoteEndpoint = payload[@"remoteEndpoint"];
    flow.remoteUrl = payload[@"remoteUrl"];
    flow.createdAt = payload[@"createdAt"];
  }];
}

- (NSUInteger)count
{
  return [[FlowModel firstValueFromQuery:@"SELECT COUNT(*) FROM $T"] unsignedIntValue];
}

@end
