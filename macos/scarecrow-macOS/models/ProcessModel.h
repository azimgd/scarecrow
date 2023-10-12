//
//  ProcessModel.h
//  scarecrow
//
//  Created by azim on 05.10.2023.
//

#ifndef ProcessModel_h
#define ProcessModel_h

#import "FCModel.h"
#import "FlowModel.h"

@interface ProcessModel : FCModel

@property (nonatomic) NSArray *safeKeys;
@property (nonatomic) NSArray *unsafeKeys;
@property (nonatomic) NSArray *keys;

@property (nonatomic) int64_t id;
@property (nonatomic, assign) NSString *bundle;
@property (nonatomic, assign) NSString *path;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *icon;

@property (nonatomic) int sumFlowSize;
@property (nonatomic) int countFlows;
@property (nonatomic, assign) NSDictionary *flows;

@end

#endif /* ProcessModel_h */
