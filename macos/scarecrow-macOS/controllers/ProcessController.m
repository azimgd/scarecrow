//
//  ProcessController.m
//  scarecrow-macOS
//
//  Created by azim on 11.10.2023.
//

#import <Foundation/Foundation.h>
#import "ProcessController.h"

@implementation ProcessController

- (NSArray *)get
{
  NSMutableArray *response = [NSMutableArray new];
  for (ProcessModel *process in [ProcessModel allInstances]) {
    [response addObject:[process dictionaryWithValuesForKeys:process.keys]];
    
    if (response.count >= 100) break;
  }

  return response;
}

- (ProcessModel *)create:(NSDictionary *)payload
{
  ProcessModel *matchedProcess = [ProcessModel firstInstanceWhere:@"path = ?", payload[@"path"]];
  if (matchedProcess.id) {
    return matchedProcess;
  }

  ProcessModel *lastProcess = [ProcessModel firstInstanceOrderedBy:@"`id` DESC"];
  ProcessModel *process = [ProcessModel instanceWithPrimaryKey:@(lastProcess.id + 1)];

  [process save:^{
    process.name = payload[@"name"];
    process.path = payload[@"path"];
    process.bundle = payload[@"bundle"];
    process.icon = payload[@"icon"];
  }];
  
  return process;
}

- (ProcessModel *)update:(NSDictionary *)payload pk:(NSUInteger)pk
{
  ProcessModel *process = [ProcessModel instanceWithPrimaryKey:@(pk)];

  [process save:^{
    process.name = payload[@"name"];
    process.path = payload[@"path"];
    process.bundle = payload[@"bundle"];
    process.icon = payload[@"icon"];
  }];
  
  return process;
}

- (NSUInteger)count
{
  return [[ProcessModel firstValueFromQuery:@"SELECT COUNT(*) FROM $T"] unsignedIntValue];
}

@end
