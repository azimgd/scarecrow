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
  });
  return sharedInstance;
}

- (NSArray *)getFlowsWithPredicate:(NSPredicate *)predicate
{
  return @[];
}

- (NSNumber *)countFlowsWithPredicate:(NSPredicate *)predicate
{
  return 0;
}

- (NSArray *)getFlowsWithGroupKeys:(NSArray<NSString *> *)groupKeys
{
  return @[];
}

- (NSNumber *)countFlowsWithGroupKeys:(NSArray<NSString *> *)groupKeys
{
  return 0;
}

- (void)createFlow:(NSDictionary *)flowPayload processPayload:(NSDictionary *)processPayload
{
}

- (void)handleFlowRuleUpdate:(NSString *)bundleIdentifier payload:(BOOL)payload
{
}

- (NSArray *)getRules
{
  return @[];
}

@end
