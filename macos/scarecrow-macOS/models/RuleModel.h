//
//  RuleModel.h
//  scarecrow
//
//  Created by azim on 02.10.2023.
//

#ifndef RuleModel_h
#define RuleModel_h

#import "FCModel.h"
#import "FlowModel.h"

@interface RuleModel : FCModel

@property (nonatomic) NSArray *keys;

@property (nonatomic) int64_t id;
@property (nonatomic) int64_t flowId;
@property (nonatomic) BOOL allowed;
@property (nonatomic) NSDate *createdAt;

@property (nonatomic) FlowModel *flow;

@end

#endif /* RuleModel_h */
