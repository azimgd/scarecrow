//
//  FlowController.m
//  scarecrow-macOS
//
//  Created by azim on 11.10.2023.
//

#import <Foundation/Foundation.h>
#import "FlowController.h"

@implementation FlowController

- (NSArray *)getAll
{
  return [FlowModel getAll];
}

- (NSDictionary *)getByPk:(int)pk
{
  FlowModel *flow = [FlowModel instanceWithPrimaryKey:@(pk)];
  return [flow dictionaryWithValuesForKeys:flow.keys];
}

- (FlowModel *)create:(NSDictionary *)payload
{
  FlowModel *lastFlow = [FlowModel firstInstanceOrderedBy:@"`id` DESC"];
  FlowModel *flow = [FlowModel instanceWithPrimaryKey:@(lastFlow.id + 1)];

  [flow save:^{
    flow.processId = [payload[@"processId"] unsignedIntValue];
    flow.identifier = payload[@"identifier"];
    flow.direction = [payload[@"direction"] intValue];
    flow.socketFamily = [payload[@"socketFamily"] intValue];
    flow.socketType = [payload[@"socketType"] intValue];
    flow.socketProtocol = [payload[@"socketProtocol"] intValue];
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
    flow.direction = [payload[@"direction"] intValue];
    flow.socketFamily = [payload[@"socketFamily"] intValue];
    flow.socketType = [payload[@"socketType"] intValue];
    flow.socketProtocol = [payload[@"socketProtocol"] intValue];
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
