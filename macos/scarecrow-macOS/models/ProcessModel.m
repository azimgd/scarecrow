//
//  ProcessModel.m
//  scarecrow-macOS
//
//  Created by azim on 05.10.2023.
//

#import <Foundation/Foundation.h>
#import "ProcessModel.h"

@implementation ProcessModel

+ (NSString *)primaryKey {
  return @"identifier";
}

+ (NSArray<NSString *> *)requiredProperties {
  return @[
    @"identifier"
  ];
}

@end
