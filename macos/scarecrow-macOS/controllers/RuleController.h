//
//  RuleController.h
//  scarecrow
//
//  Created by azim on 11.10.2023.
//

#ifndef RuleController_h
#define RuleController_h

#import "RuleModel.h"

@interface RuleController : NSObject

- (NSArray *)get;
- (void)create:(NSDictionary *)payload;
- (void)update:(NSDictionary *)payload pk:(NSUInteger)pk;
- (NSUInteger)count;
@end

#endif /* RuleController_h */
