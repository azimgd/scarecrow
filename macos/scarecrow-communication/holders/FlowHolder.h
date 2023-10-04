//
//  FlowHolder.h
//  scarecrow-network
//
//  Created by azim on 17.09.2023.
//

#ifndef FlowHolder_h
#define FlowHolder_h

#import <NetworkExtension/NetworkExtension.h>
#import <bsm/libbsm.h>
#import <AppKit/AppKit.h>

@interface FlowHolder : NSObject

@property (nonatomic, copy) NEFilterFlow *flow;
@property (nonatomic, copy) NSNumber *size;
@property (nonatomic, copy) NSDate *date;

- (instancetype)init:(NEFilterFlow *)flow size:(NSNumber *)size;
- (NSDictionary *)payload;

@end

#endif /* FlowHolder_h */
