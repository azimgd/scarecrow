//
//  RCTScarecrowNetwork.m
//  scarecrow-macOS
//
//  Created by azim on 15.09.2023.
//

#import <Foundation/Foundation.h>
#import "RCTScarecrowNetwork.h"

@implementation RCTScarecrowNetwork

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(enable)
{
  [[NetworkExtensionProvider shared] enable];
}

RCT_EXPORT_METHOD(disable)
{
  [[NetworkExtensionProvider shared] disable];
}

@end
