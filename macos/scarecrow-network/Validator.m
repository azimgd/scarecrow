//
//  Validator.m
//  scarecrow-network
//
//  Created by azim on 29.09.2023.
//

#import <Foundation/Foundation.h>
#import "Validator.h"

@implementation Validator

static Validator *sharedInstance = nil;

+ (Validator *)shared
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[Validator alloc] init];
    
    sharedInstance.rules = [[NSMutableDictionary alloc] initWithDictionary:@{}];
    [[NSNotificationCenter defaultCenter]addObserver:sharedInstance selector:@selector(handleFlowRuleUpdate:) name:@"handleFlowRuleUpdate" object:nil];
  });
  return sharedInstance;
}

- (void)handleFlowRuleUpdate:(NSNotification*)sender {
  NSString *bundleIdentifier = sender.userInfo[@"bundleIdentifier"];
  BOOL payload = [sender.userInfo[@"payload"] boolValue];
  sharedInstance.rules[bundleIdentifier] = @(payload);
}

@end
