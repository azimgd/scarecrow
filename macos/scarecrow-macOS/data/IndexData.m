//
//  IndexData.m
//  scarecrow-macOS
//
//  Created by azim on 02.10.2023.
//

#import <Foundation/Foundation.h>
#import "IndexData.h"
#import "ProcessHelpers.h"

@implementation IndexData

static IndexData *sharedInstance = nil;

+ (IndexData *)shared
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[IndexData alloc] init];
    sharedInstance.flowKeys = @[
      @"direction",
      @"remoteEndpoint",
      @"remoteUrl",
      @"name",
      @"bundleIdentifier",
    ];
    sharedInstance.ruleKeys = @[
      @"remoteEndpoint",
      @"bundleIdentifier",
      @"allowed"
    ];
  });
  return sharedInstance;
}

- (NSArray *)getFlowsWithPredicate:(NSPredicate *)predicate
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *flows = [FlowModel objectsInRealm:realm withPredicate:predicate];

  NSMutableArray *response = [NSMutableArray array];

  for (FlowModel *flow in flows) {
    NSDictionary *flowDictionary = [flow dictionaryWithValuesForKeys:sharedInstance.flowKeys];
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:flowDictionary];
    
    item[@"icon"] = getIconForExecutablePath(flow.bundleIdentifier);

    [response addObject:item];
    
    if (response.count >= 100) {
      break;
    }
  }
  
  return response;
}

- (NSNumber *)countFlowsWithPredicate:(NSPredicate *)predicate
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *flows = [FlowModel objectsInRealm:realm withPredicate:predicate];

  return @(flows.count);
}

- (NSArray *)getFlowsWithGroupKeys:(NSArray<NSString *> *)groupKeys
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *flows = [FlowModel allObjectsInRealm:realm];
  RLMResults *distinctFlows = [flows distinctResultsUsingKeyPaths:groupKeys];

  NSMutableArray *response = [NSMutableArray array];

  for (FlowModel *flow in distinctFlows) {
    NSDictionary *flowDictionary = [flow dictionaryWithValuesForKeys:sharedInstance.flowKeys];
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:flowDictionary];

    NSString *propertyName = groupKeys.firstObject;
    NSString *valueToMatch = flow[propertyName];
    NSString *predicateFormat = [NSString stringWithFormat:@"%@ = %%@", propertyName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat, valueToMatch];

    RLMResults *flows = [FlowModel objectsInRealm:realm withPredicate:predicate];
    item[@"totalCount"] = @([flows count]);
    item[@"icon"] = getIconForExecutablePath(flow.bundleIdentifier);

    [response addObject:item];
    
    if (response.count >= 100) {
      break;
    }
  }
  
  return response;
}

- (NSNumber *)countFlowsWithGroupKeys:(NSArray<NSString *> *)groupKeys
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *flows = [FlowModel allObjectsInRealm:realm];
  RLMResults *distinctFlows = [flows distinctResultsUsingKeyPaths:groupKeys];

  return @(distinctFlows.count);
}

- (void)createFlow:(NSDictionary *)flowPayload processPayload:(NSDictionary *)processPayload
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  FlowModel *flow = [[FlowModel alloc] initWithValue:@{
    @"identifier": flowPayload[@"identifier"] ?: @"",
    @"direction": flowPayload[@"direction"] ?: @"",
    @"remoteEndpoint": flowPayload[@"remoteEndpoint"] ?: @"",
    @"remoteUrl": flowPayload[@"remoteUrl"] ?: @"",
    @"path": processPayload[@"path"] ?: @"",
    @"name": processPayload[@"name"] ?: @"",
    @"bundleIdentifier": processPayload[@"bundleIdentifier"] ?: @"",
  }];

  [realm transactionWithBlock:^() {
    [realm addOrUpdateObject:flow];
  }];
}

- (void)handleFlowRuleUpdate:(NSString *)bundleIdentifier payload:(BOOL)payload
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bundleIdentifier = %@", bundleIdentifier];
  RLMResults *rules = [RuleModel objectsWithPredicate:predicate];

  [realm transactionWithBlock:^() {
    if (rules.count) {
      RuleModel *rule = rules.firstObject;
      rule.allowed = payload;
    } else {
      RuleModel *rule = [[RuleModel alloc] initWithValue:@{
        @"identifier": [[NSUUID UUID] UUIDString],
        @"bundleIdentifier": bundleIdentifier,
        @"remoteEndpoint": @"",
        @"allowed": @(NO),
      }];
      [realm addObject:rule];
    }
  }];
}

- (NSArray *)getRules
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *rules = [RuleModel allObjectsInRealm:realm];

  NSMutableArray *response = [NSMutableArray array];

  for (RuleModel *rule in rules) {
    NSDictionary *ruleDictionary = [rule dictionaryWithValuesForKeys:sharedInstance.ruleKeys];
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:ruleDictionary];

    [response addObject:item];
  }
  
  return response;
}

@end
