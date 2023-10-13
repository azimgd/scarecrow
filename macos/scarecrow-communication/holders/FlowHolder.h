//
//  FlowHolder.h
//  scarecrow-network
//
//  Created by azim on 17.09.2023.
//

#ifndef FlowHolder_h
#define FlowHolder_h

#import <NetworkExtension/NetworkExtension.h>

@interface FlowHolder : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *remoteEndpoint;
@property (nonatomic, copy) NSString *remoteUrl;
@property (nonatomic, assign) int direction;
@property (nonatomic, assign) int socketFamily;
@property (nonatomic, assign) int socketType;
@property (nonatomic, assign) int socketProtocol;
@property (nonatomic, assign) int size;

- (instancetype)init:(NEFilterFlow *)flow size:(int)size;
- (NSDictionary *)payload;

@end

#endif /* FlowHolder_h */
