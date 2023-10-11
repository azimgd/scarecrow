//
//  ProcessController.h
//  scarecrow
//
//  Created by azim on 11.10.2023.
//

#ifndef ProcessController_h
#define ProcessController_h

#import "ProcessModel.h"

@interface ProcessController : NSObject

- (NSArray *)get;
- (void)create:(NSDictionary *)payload;
- (void)update:(NSDictionary *)payload pk:(NSUInteger)pk;
- (NSUInteger)count;
@end

#endif /* ProcessController_h */
