//
//  Communication.m
//  scarecrow-filter-data
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

- (void)initialize {
}

@end
