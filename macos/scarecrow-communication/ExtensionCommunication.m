//
//  Communication.m
//  scarecrow-network
//
//  Created by azim on 12.09.2023.
//

#import <Foundation/Foundation.h>
#import "ExtensionCommunication.h"

@implementation ExtensionCommunication

static ExtensionCommunication *sharedInstance = nil;

+ (ExtensionCommunication *)shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[ExtensionCommunication alloc] init];
  });
  return sharedInstance;
}

- (void)handleConnectionStart {
}

- (void)handleConnectionStop {
}

- (void)handleFlowRuleUpdate:(NSString *)bundleIdentifier payload:(BOOL)payload
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"handleFlowRuleUpdate" object:nil userInfo:@{
    @"bundleIdentifier": bundleIdentifier,
    @"payload": @(payload),
  }];
}

@end
