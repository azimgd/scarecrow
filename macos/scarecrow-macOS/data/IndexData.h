//
//  IndexData.h
//  scarecrow
//
//  Created by azim on 02.10.2023.
//

#ifndef IndexData_h
#define IndexData_h

#import "IndexData.h"
#import "FlowModel.h"
#import "RuleModel.h"

@interface IndexData : NSObject

@property (class, nonatomic, readonly) IndexData *shared;
@property (nonatomic, copy) NSArray *flowKeys;
@property (nonatomic, copy) NSArray *ruleKeys;

- (NSArray *)getFlowsWithPredicate:(NSPredicate *)predicate;
- (NSNumber *)countFlowsWithPredicate:(NSPredicate *)predicate;
- (NSArray *)getFlowsWithGroupKeys:(NSArray<NSString *> *)groupKeys;
- (NSNumber *)countFlowsWithGroupKeys:(NSArray<NSString *> *)groupKeys;
- (void)createFlow:(NSDictionary *)flowPayload processPayload:(NSDictionary *)processPayload;
- (void)handleFlowRuleUpdate:(NSString *)bundleIdentifier payload:(BOOL)payload;
- (NSArray *)getRules;

@end


#endif /* IndexData_h */
