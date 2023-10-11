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

- (NSArray *)get;
- (void)create:(NSDictionary *)payload;
- (NSUInteger)count;

@end

#endif /* FlowController_h */
