//
//  IndexData.m
//  scarecrow-macOS
//
//  Created by azim on 02.10.2023.
//

#import <Foundation/Foundation.h>
#import "IndexData.h"

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
      @"localizedName",
      @"bundleIdentifier",
      @"size",
      @"date"
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
  RLMResults *flows = [Flow objectsInRealm:realm withPredicate:predicate];
  RLMResults *sortedFlows = [flows sortedResultsUsingKeyPath:@"date" ascending:NO];

  NSMutableArray *response = [NSMutableArray array];

  for (Flow *flow in sortedFlows) {
    NSDictionary *flowDictionary = [flow dictionaryWithValuesForKeys:sharedInstance.flowKeys];
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:flowDictionary];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    item[@"date"] = [dateFormat stringFromDate:item[@"date"]];
    
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
  RLMResults *flows = [Flow objectsInRealm:realm withPredicate:predicate];

  return @(flows.count);
}

- (NSArray *)getFlowsWithGroupKeys:(NSArray<NSString *> *)groupKeys
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults *flows = [Flow allObjectsInRealm:realm];
  RLMResults *sortedFlows = [flows sortedResultsUsingKeyPath:@"date" ascending:NO];
  RLMResults *distinctFlows = [sortedFlows distinctResultsUsingKeyPaths:groupKeys];

  NSMutableArray *response = [NSMutableArray array];

  for (Flow *flow in distinctFlows) {
    NSDictionary *flowDictionary = [flow dictionaryWithValuesForKeys:sharedInstance.flowKeys];
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:flowDictionary];

    NSString *propertyName = groupKeys.firstObject;
    NSString *valueToMatch = flow[propertyName];
    NSString *predicateFormat = [NSString stringWithFormat:@"%@ = %%@", propertyName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat, valueToMatch];

    RLMResults *flows = [Flow objectsInRealm:realm withPredicate:predicate];
    item[@"totalSize"] = [flows sumOfProperty:@"size"];
    item[@"totalCount"] = @([flows count]);

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
  RLMResults *flows = [Flow allObjectsInRealm:realm];
  RLMResults *distinctFlows = [flows distinctResultsUsingKeyPaths:groupKeys];

  return @(distinctFlows.count);
}

- (void)createFlow:(NSDictionary *)payload
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  Flow *flow = [[Flow alloc] initWithValue:payload];

  [realm transactionWithBlock:^() {
    [realm addOrUpdateObject:flow];
  }];
}

- (void)updateFlowRule:(NSString *)bundleIdentifier payload:(BOOL)payload
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bundleIdentifier = %@", bundleIdentifier];
  RLMResults *rules = [Rule objectsWithPredicate:predicate];

  [realm transactionWithBlock:^() {
    if (rules.count) {
      Rule *rule = rules.firstObject;
      rule.allowed = payload;
    } else {
      Rule *rule = [[Rule alloc] initWithValue:@{
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
  RLMResults *rules = [Rule allObjectsInRealm:realm];

  NSMutableArray *response = [NSMutableArray array];

  for (Rule *rule in rules) {
    NSDictionary *ruleDictionary = [rule dictionaryWithValuesForKeys:sharedInstance.ruleKeys];
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:ruleDictionary];

    [response addObject:item];
  }
  
  return response;
}

@end
