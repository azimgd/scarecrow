//
//  ProcessModel.m
//  scarecrow-macOS
//
//  Created by azim on 05.10.2023.
//

#import <Foundation/Foundation.h>
#import "ProcessModel.h"

@implementation ProcessModel

- (void)didInit
{
  _safeKeys = @[
    @"id",
    @"bundle",
    @"path",
    @"name",
    @"icon",
    @"createdAt",
    @"updatedAt",
  ];
  
  _unsafeKeys = @[
    @"sumFlowSize",
    @"countFlows",
    @"flows",
  ];
  
  _keys = [_safeKeys arrayByAddingObjectsFromArray:_unsafeKeys];
}

+ (NSArray *)getAll
{
  NSMutableArray *response = [NSMutableArray new];
  for (ProcessModel *process in [ProcessModel instancesOrderedBy:@"updatedAt DESC"]) {
    [response addObject:[process dictionaryWithValuesForKeys:process.keys]];
  }

  return response;
}

- (BOOL)save:(void (^)(void))modificiationsBlock
{
  return [super save:^{
    if (!self.createdAt) self.createdAt = [NSDate date];
    if (!self.updatedAt) self.updatedAt = [NSDate date];
    modificiationsBlock();
  }];
}

+ (NSDictionary *)getByPk:(int)pk
{
  ProcessModel *process = [ProcessModel instanceWithPrimaryKey:@(pk)];
  return [process dictionaryWithValuesForKeys:process.keys];
}

- (int)sumFlowSize
{
  return [[FlowModel firstValueFromQuery:@"SELECT SUM(size) FROM FlowModel WHERE processId = ?", @(self.id)] intValue];
}

- (int)countFlows
{
  return [[FlowModel firstValueFromQuery:@"SELECT COUNT(*) FROM FlowModel WHERE processId = ?", @(self.id)] intValue];
}

- (NSArray *)flows
{
  NSMutableArray *response = [NSMutableArray new];
  for (FlowModel *flow in [FlowModel instancesWhere:@"processId = ? ORDER BY createdAt DESC LIMIT 5", @(self.id)]) {
    [response addObject:[flow dictionaryWithValuesForKeys:flow.safeKeys]];
  }

  return response;
}

@end
