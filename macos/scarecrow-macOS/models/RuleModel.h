//
//  RuleModel.h
//  scarecrow
//
//  Created by azim on 02.10.2023.
//

#ifndef RuleModel_h
#define RuleModel_h

#import "FCModel.h"
#import "ProcessModel.h"

@interface RuleModel : FCModel

@property (nonatomic) NSArray *safeKeys;
@property (nonatomic) NSArray *unsafeKeys;
@property (nonatomic) NSArray *keys;

@property (nonatomic) int64_t id;
@property (nonatomic) int64_t processId;
@property (nonatomic) BOOL allowed;
@property (nonatomic) NSDate *createdAt;

@property (nonatomic) NSDictionary *process;

@end

#endif /* RuleModel_h */
