//
//  ProcessHolder.h
//  scarecrow
//
//  Created by azim on 04.10.2023.
//

#ifndef ProcessHolder_h
#define ProcessHolder_h

#import <bsm/libbsm.h>
#import <libproc.h>
#import <sys/sysctl.h>
#import <AppKit/AppKit.h>

@interface ProcessHolder : NSObject

@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *name;

- (instancetype)init:(audit_token_t *)auditToken;

- (NSDictionary *)payload;

- (NSString *)getProcessPathForPID:(pid_t)processID;
- (NSString *)getProcessNameForPID:(pid_t)processID executablePath:(NSString *)executablePath;

@end


#endif /* ProcessHolder_h */
