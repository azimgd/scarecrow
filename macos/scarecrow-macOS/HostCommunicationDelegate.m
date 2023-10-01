//
//  HostCommunicationDelegate.m
//  scarecrow-macOS
//
//  Created by azim on 23.09.2023.
//

#import <Foundation/Foundation.h>
#import "HostCommunicationDelegate.h"
#import "Flow.h"

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
  RLMRealm *realm = [RLMRealm defaultRealm];
  Flow *flow = [[Flow alloc] initWithValue:payload];
  [realm transactionWithBlock:^() {
    [realm addOrUpdateObject:flow];
  }];

  [[NSNotificationCenter defaultCenter] postNotificationName:@"handleDataFromFlowEvent" object:nil userInfo:payload];

  [self saveFlow:payload];
}

- (void)saveFlow:(NSDictionary *)payload
{
}

- (BOOL)validateFlowForBundleIdentifier:(NSString *)bundleIdentifier
{
  BOOL status = YES;
  return status;
}

- (void)toggleFlowRule:(NSString *)bundleIdentifier
{
  BOOL status = YES;
}

@end
