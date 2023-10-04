//
//  ProcessHolder.h
//  scarecrow
//
//  Created by azim on 04.10.2023.
//

#ifndef ProcessHolder_h
#define ProcessHolder_h

#import <bsm/libbsm.h>
#import <AppKit/AppKit.h>

@interface ProcessHolder : NSObject

@property (nonatomic, copy) NSRunningApplication *runningApplication;

- (instancetype)init:(audit_token_t *)auditToken;

- (NSDictionary *)payload;
- (NSRunningApplication *)runningApplicationFromAppAuditToken:(audit_token_t *)auditToken;

@end


#endif /* ProcessHolder_h */
