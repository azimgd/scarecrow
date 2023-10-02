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

- (void)startConnection {
}

- (void)stopConnection {
}

- (void)updateFlowRule:(NSString *)bundleIdentifier
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"updateFlowRule" object:nil userInfo:@{
    @"bundleIdentifier": bundleIdentifier,
  }];
}

@end
