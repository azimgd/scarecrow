//
//  FlowModel.m
//  scarecrow-macOS
//
//  Created by azim on 30.09.2023.
//

#import <Foundation/Foundation.h>
#import "FlowModel.h"

@implementation FlowModel

+ (NSString *)primaryKey {
  return @"identifier";
}

+ (NSArray<NSString *> *)requiredProperties {
  return @[
    @"identifier"
  ];
}

@end
