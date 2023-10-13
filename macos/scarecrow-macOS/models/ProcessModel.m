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
  ];
  
  _unsafeKeys = @[
    @"sumFlowSize",
    @"countFlows",
    @"flows",
  ];
  
  _keys = [_safeKeys arrayByAddingObjectsFromArray:_unsafeKeys];
}

- (int)sumFlowSize
{
  return [[FlowModel firstValueFromQuery:@"SELECT SUM(size) FROM FlowModel"] intValue];
}

- (int)countFlows
{
  return [[FlowModel firstValueFromQuery:@"SELECT COUNT(*) FROM FlowModel where processId = ?", @(self.id)] intValue];
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
