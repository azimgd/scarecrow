//
//  FlowController.h
//  scarecrow
//
//  Created by azim on 11.10.2023.
//

#ifndef FlowController_h
#define FlowController_h

#import "FlowModel.h"

@interface FlowController : NSObject

- (NSArray *)getAll;
- (NSDictionary *)getByPk:(int)pk;
- (FlowModel *)create:(NSDictionary *)payload;
- (FlowModel *)update:(NSDictionary *)payload pk:(NSUInteger)pk;
- (NSUInteger)count;

@end

#endif /* FlowController_h */
