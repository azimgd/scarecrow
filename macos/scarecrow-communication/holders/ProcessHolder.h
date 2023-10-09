//
//  ProcessHolder.h
//  scarecrow
//
//  Created by azim on 04.10.2023.
//

#ifndef ProcessHolder_h
#define ProcessHolder_h

#import <NetworkExtension/NetworkExtension.h>
#import <AppKit/AppKit.h>
#import <bsm/libbsm.h>
#import <libproc.h>
#import <sys/sysctl.h>

@interface ProcessHolder : NSObject

@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *bundleIdentifier;

- (instancetype)init:(NEFilterFlow *)flow;
- (NSDictionary *)payload;
@end


#endif /* ProcessHolder_h */
