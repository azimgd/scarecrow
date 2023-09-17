//
//  FlowEntry.h
//  scarecrow-network
//
//  Created by azim on 17.09.2023.
//

#ifndef FlowEntry_h
#define FlowEntry_h

#import <NetworkExtension/NetworkExtension.h>
#import <bsm/libbsm.h>
#import <AppKit/AppKit.h>

@interface FlowEntry : NSObject

@property (nonatomic, copy) NEFilterFlow *flow;

- (instancetype)initWithFlow:(NEFilterFlow *)flow;
- (NSDictionary *)payload;

@end

#endif /* FlowEntry_h */
