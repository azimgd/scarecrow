//
//  Rule.m
//  scarecrow
//
//  Created by azim on 23.09.2023.
//

#import <Foundation/Foundation.h>
#import "Rule.h"

@implementation Rule

+ (NSString *)primaryKey {
  return @"bundleIdentifier";
}

- (NSDictionary *)payload {
  return @{
    @"bundleIdentifier": self.bundleIdentifier ?: [NSNull null],
    @"allowed": self.allowed ? @YES : @NO
  };
}

@end
