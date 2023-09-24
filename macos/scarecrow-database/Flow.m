//
//  Flow.m
//  scarecrow-macOS
//
//  Created by azim on 19.09.2023.
//

#import <Foundation/Foundation.h>
#import "Flow.h"

@implementation Flow

+ (NSString *)primaryKey {
  return @"_id";
}

- (NSDictionary *)payload {
  return @{
    @"_id": self._id ?: [NSNull null],
    @"direction": self.direction ?: [NSNull null],
    @"remoteEndpoint": self.remoteEndpoint ?: [NSNull null],
    @"remoteUrl": self.remoteUrl ?: [NSNull null],
    @"localizedName": self.localizedName ?: [NSNull null],
    @"bundleIdentifier": self.bundleIdentifier ?: [NSNull null],
  };
}

@end
