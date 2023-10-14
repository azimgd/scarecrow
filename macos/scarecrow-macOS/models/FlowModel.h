//
//  FlowModel.h
//  scarecrow
//
//  Created by azim on 30.09.2023.
//

#ifndef FlowModel_h
#define FlowModel_h

#import "FCModel.h"
#import "ProcessModel.h"

@interface FlowModel : FCModel

@property (nonatomic) NSArray *safeKeys;
@property (nonatomic) NSArray *unsafeKeys;
@property (nonatomic) NSArray *keys;

@property (nonatomic) int64_t id;
@property (nonatomic) int64_t processId;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) int direction;
@property (nonatomic, assign) int socketFamily;
@property (nonatomic, assign) int socketType;
@property (nonatomic, assign) int socketProtocol;
@property (nonatomic, copy) NSString *remoteEndpoint;
@property (nonatomic, copy) NSString *remoteUrl;
@property (nonatomic, assign) int size;
@property (nonatomic) NSDate *createdAt;
@property (nonatomic) NSDate *updatedAt;

@property (nonatomic, assign) NSDictionary *process;
@property (nonatomic, assign) NSArray *distinctRemoteEndpoints;

+ (NSArray *)getAll;
+ (NSDictionary *)getByPk:(int)pk;

@end

#endif /* FlowModel_h */
