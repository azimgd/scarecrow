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
  for (RuleModel *rule in [RuleModel instancesOrderedBy:@"`createdAt` DESC LIMIT 5"]) {
    [response addObject:[rule dictionaryWithValuesForKeys:rule.keys]];
  }

  return response;
}

- (RuleModel *)create:(NSDictionary *)payload
{
  RuleModel *matchedRule = [RuleModel firstInstanceWhere:@"processId = ?", payload[@"processId"]];
  if (matchedRule.id) {
    return matchedRule;
  }

  RuleModel *lastRule = [RuleModel firstInstanceOrderedBy:@"`id` DESC"];
  RuleModel *rule = [RuleModel instanceWithPrimaryKey:@(lastRule.id + 1)];

  [rule save:^{
    rule.processId = [payload[@"processId"] unsignedIntValue];
    rule.allowed = payload[@"allowed"];
  }];
  
  return rule;
}

- (RuleModel *)update:(NSDictionary *)payload pk:(NSUInteger)pk
{
  RuleModel *rule = [RuleModel instanceWithPrimaryKey:@(pk)];

  [rule save:^{
    rule.processId = [payload[@"processId"] unsignedIntValue];
    rule.allowed = payload[@"allowed"];
  }];
  
  return rule;
}

- (NSUInteger)count
{
  return [[RuleModel firstValueFromQuery:@"SELECT COUNT(*) FROM $T"] unsignedIntValue];
}

@end
