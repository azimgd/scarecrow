//
//  Flow.m
//  scarecrow-macOS
//
//  Created by azim on 30.09.2023.
//

#import <Foundation/Foundation.h>
#import "Flow.h"

@implementation Flow

+ (NSString *)primaryKey {
  return @"identifier";
}

+ (NSArray<NSString *> *)requiredProperties {
  return @[
    @"identifier"
  ];
}

@end
