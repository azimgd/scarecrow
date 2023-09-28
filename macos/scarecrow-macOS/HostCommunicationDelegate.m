//
//  HostCommunicationDelegate.m
//  scarecrow-macOS
//
//  Created by azim on 23.09.2023.
//

#import <Foundation/Foundation.h>
#import "HostCommunicationDelegate.h"

@implementation HostCommunicationDelegate

static HostCommunicationDelegate *sharedInstance = nil;

+ (HostCommunicationDelegate *)shared
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[HostCommunicationDelegate alloc] init];
  });
  return sharedInstance;
}

- (void)startConnection
{
}

- (void)stopConnection
{
}

- (void)handleDataFromFlowEvent:(NSDictionary *)payload
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"handleDataFromFlowEvent" object:nil userInfo:payload];

  [self saveFlow:payload];
}

- (void)validateRuleForFlowEvent:(NSDictionary *)payload withCallback:(void(^)(BOOL allowed))callback
{
  NSString *bundleIdentifier = [payload objectForKey:@"bundleIdentifier"];
  callback([self validateFlowForBundleIdentifier:bundleIdentifier]);
}

- (void)saveFlow:(NSDictionary *)payload
{
}

- (BOOL)validateFlowForBundleIdentifier:(NSString *)bundleIdentifier
{
  BOOL status = YES;
  return status;
}

- (void)toggleFlowRule:(NSString *)bundleIdentifier withCallback:(void(^)(BOOL status))callback
{
  BOOL status = YES;
  callback(status);
}

@end
