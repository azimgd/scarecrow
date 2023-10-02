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
  }
  
  return response;
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
  }
  
  return response;
}

- (void)createFlow:(NSDictionary *)payload
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  Flow *flow = [[Flow alloc] initWithValue:payload];

  [realm transactionWithBlock:^() {
    [realm addOrUpdateObject:flow];
  }];
}

@end
