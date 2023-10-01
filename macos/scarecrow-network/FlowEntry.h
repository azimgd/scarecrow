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
@property (nonatomic, copy) NSNumber *size;
@property (nonatomic, copy) NSDate *date;

- (instancetype)initWithFlow:(NEFilterFlow *)flow size:(NSNumber *)size;
- (NSDictionary *)payload;

@end

#endif /* FlowEntry_h */
