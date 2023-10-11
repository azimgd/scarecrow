//
//  FlowModel.h
//  scarecrow
//
//  Created by azim on 30.09.2023.
//

#ifndef FlowModel_h
#define FlowModel_h

#import "FCModel.h"

@interface FlowModel : FCModel

@property (nonatomic) int64_t id;
@property (nonatomic, copy) NSString *direction;
@property (nonatomic, copy) NSString *remoteEndpoint;
@property (nonatomic, copy) NSString *remoteUrl;
@property (nonatomic) NSDate *createdAt;

@end

#endif /* FlowModel_h */
