//
//  ProcessModel.h
//  scarecrow
//
//  Created by azim on 05.10.2023.
//

#ifndef ProcessModel_h
#define ProcessModel_h

#import "FCModel.h"

@interface ProcessModel : FCModel

@property (nonatomic) int64_t id;
@property (nonatomic, assign) NSString *bundleIdentifier;
@property (nonatomic, assign) NSString *path;
@property (nonatomic, assign) NSString *name;
@property (nonatomic) NSDate *createdAt;

@end

#endif /* ProcessModel_h */
