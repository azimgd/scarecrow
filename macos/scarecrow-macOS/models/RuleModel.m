//
//  RuleModel.m
//  scarecrow-macOS
//
//  Created by azim on 02.10.2023.
//

#import <Foundation/Foundation.h>
#import "RuleModel.h"

@implementation RuleModel

- (void)didInit
{
  _keys = @[
    @"id",
    @"direction",
    @"remoteEndpoint",
    @"remoteUrl",
    @"createdAt",
  ];
}

@end
