//
//  FlowModel.m
//  scarecrow-macOS
//
//  Created by azim on 30.09.2023.
//

#import <Foundation/Foundation.h>
#import "FlowModel.h"

@implementation FlowModel

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
