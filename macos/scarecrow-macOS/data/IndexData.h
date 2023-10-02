//
//  IndexData.h
//  scarecrow
//
//  Created by azim on 02.10.2023.
//

#ifndef IndexData_h
#define IndexData_h

#import "IndexData.h"
#import "Flow.h"

@interface IndexData : NSObject

@property (class, nonatomic, readonly) IndexData *shared;
@property (nonatomic, copy) NSArray *flowKeys;

- (NSArray *)getFlowsWithPredicate:(NSPredicate *)predicate;
- (NSArray *)getFlowsWithGroupKeys:(NSArray<NSString *> *)groupKeys;
- (void)createFlow:(NSDictionary *)payload;

@end


#endif /* IndexData_h */
