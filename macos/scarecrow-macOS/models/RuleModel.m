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
  _safeKeys = @[
    @"id",
    @"processId",
    @"allowed",
    @"createdAt",
  ];
  
  _unsafeKeys = @[
    @"process",
  ];
  
  _keys = [_safeKeys arrayByAddingObjectsFromArray:_unsafeKeys];
}

- (BOOL)save:(void (^)(void))modificiationsBlock
{
  return [super save:^{
    if (!self.createdAt) self.createdAt = [NSDate date];
    modificiationsBlock();
  }];
}

- (NSDictionary *)process
{
  ProcessModel *process = [ProcessModel instanceWithPrimaryKey:@(self.processId)];
  return [process dictionaryWithValuesForKeys:process.safeKeys];
}

@end
