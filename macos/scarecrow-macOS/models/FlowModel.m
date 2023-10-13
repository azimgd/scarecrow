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
  _safeKeys = @[
    @"id",
    @"processId",
    @"identifier",
    @"direction",
    @"socketFamily",
    @"socketType",
    @"socketProtocol",
    @"remoteEndpoint",
    @"remoteUrl",
    @"size",
    @"createdAt",
  ];
  _unsafeKeys = @[
    @"process",
    @"distinctRemoteEndpoints",
  ];

  _keys = [_safeKeys arrayByAddingObjectsFromArray:_unsafeKeys];
}

+ (NSArray *)getAll
{
  NSMutableArray *response = [NSMutableArray new];
  for (FlowModel *flow in [FlowModel instancesOrderedBy:@"`createdAt` DESC LIMIT 5"]) {
    [response addObject:[flow dictionaryWithValuesForKeys:flow.keys]];
  }

  return response;
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
  return [process dictionaryWithValuesForKeys:process.keys];
}

- (NSArray *)distinctRemoteEndpoints
{
  NSMutableArray *response = [NSMutableArray new];
  for (FlowModel *flow in [FlowModel resultDictionariesFromQuery:@"SELECT DISTINCT remoteEndpoint FROM FlowModel ORDER BY createdAt"]) {
    [response addObject:[flow dictionaryWithValuesForKeys:self.safeKeys]];
  }

  return response;
}

@end
