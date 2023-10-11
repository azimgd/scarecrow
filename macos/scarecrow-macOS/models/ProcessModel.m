//
//  ProcessModel.m
//  scarecrow-macOS
//
//  Created by azim on 05.10.2023.
//

#import <Foundation/Foundation.h>
#import "ProcessModel.h"
#import "FlowModel.h"

@implementation ProcessModel

- (void)didInit
{
  _keys = @[
    @"id",
    @"bundle",
    @"path",
    @"name",
    @"icon",
    @"sumFlowSize",
    @"countFlows",
  ];
}

- (int)sumFlowSize
{
  return [[FlowModel firstValueFromQuery:@"SELECT SUM(size) FROM FlowModel"] intValue];
}

- (int)countFlows
{
  return [[FlowModel firstValueFromQuery:@"SELECT COUNT(*) FROM FlowModel where processId = ?", @(self.id)] intValue];
}

@end
