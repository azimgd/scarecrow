//
//  Rule.m
//  scarecrow-macOS
//
//  Created by azim on 02.10.2023.
//

#import <Foundation/Foundation.h>
#import "Rule.h"

@implementation Rule

+ (NSString *)primaryKey {
  return @"identifier";
}

+ (NSArray<NSString *> *)requiredProperties {
  return @[
    @"identifier"
  ];
}

@end
