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
    @"processId",
    @"allowed",
    @"process",
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

- (ProcessModel *)process
{
  ProcessModel *process = [ProcessModel instanceWithPrimaryKey:@(self.processId)];
  return [process dictionaryWithValuesForKeys:process.keys];
}

@end
