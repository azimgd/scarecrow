//
//  FlowModel.m
//  scarecrow-macOS
//
//  Created by azim on 30.09.2023.
//

#import <Foundation/Foundation.h>
#import "FlowModel.h"

@implementation FlowModel

- (void)didInit
{
  _keys = @[
    @"id",
    @"processId",
    @"identifier",
    @"direction",
    @"remoteEndpoint",
    @"remoteUrl",
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
