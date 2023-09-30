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
    [[NSNotificationCenter defaultCenter]addObserver:sharedInstance selector:@selector(toggleFlowRule:) name:@"toggleFlowRule" object:nil];
  });
  return sharedInstance;
}

- (void)toggleFlowRule:(NSNotification*)sender {
  NSString *bundleIdentifier = [sender.userInfo objectForKey:@"bundleIdentifier"];
  
  NSLog(@"wiwi contains %@ %@", bundleIdentifier, sharedInstance.rules);
  if (sharedInstance.rules[bundleIdentifier] == nil) {
    sharedInstance.rules[bundleIdentifier] = @YES;
  } else {
    sharedInstance.rules[bundleIdentifier] = @(![sharedInstance.rules[bundleIdentifier] boolValue]);
  }
}

- (BOOL)validate:(NSString *)bundleIdentifier {
  if ([sharedInstance.rules doesContain:bundleIdentifier]) {
    return [sharedInstance.rules[bundleIdentifier] boolValue];
  } else {
    return YES;
  }
}

@end
