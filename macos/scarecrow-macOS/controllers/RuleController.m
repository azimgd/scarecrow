//
//  RuleController.m
//  scarecrow-macOS
//
//  Created by azim on 11.10.2023.
//

#import <Foundation/Foundation.h>
#import "RuleController.h"

@implementation RuleController

- (NSArray *)get
{
  NSMutableArray *response = [NSMutableArray new];
  for (RuleModel *rule in [RuleModel allInstances]) {
    [response addObject:[rule dictionaryWithValuesForKeys:rule.keys]];
    
    if (response.count >= 100) break;
  }

  return response;
}

- (void)create:(NSDictionary *)payload
{
  RuleModel *lastRule = [RuleModel firstInstanceOrderedBy:@"`id` DESC"];
  RuleModel *rule = [RuleModel instanceWithPrimaryKey:@(lastRule.id + 1)];

  [rule save:^{
    rule.allowed = payload[@"allowed"];
  }];
}

- (void)update:(NSDictionary *)payload pk:(NSUInteger)pk
{
  RuleModel *rule = [RuleModel instanceWithPrimaryKey:@(pk)];

  [rule save:^{
    rule.allowed = payload[@"allowed"];
  }];
}

- (NSUInteger)count
{
  return [[RuleModel firstValueFromQuery:@"SELECT COUNT(*) FROM $T"] unsignedIntValue];
}

@end
