//
//  RuleModel.m
//  scarecrow-macOS
//
//  Created by azim on 02.10.2023.
//

#import <Foundation/Foundation.h>
#import "RuleModel.h"

@implementation RuleModel

- (void)didInit
{
  _keys = @[
    @"id",
    @"flowId",
    @"allowed",
    @"flow",
    @"createdAt",
  ];
}

- (BOOL)save:(void (^)(void))modificiationsBlock
{
  return [super save:^{
    if (!self.createdAt) self.createdAt = [NSDate date];
    modificiationsBlock();
  }];
}

- (FlowModel *)flow
{
  FlowModel *flow = [FlowModel instanceWithPrimaryKey:@(self.flowId)];
  return [flow dictionaryWithValuesForKeys:flow.keys];
}

@end
