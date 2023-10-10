//
//  ProcessModel.h
//  scarecrow
//
//  Created by azim on 05.10.2023.
//

#ifndef ProcessModel_h
#define ProcessModel_h

#import <Realm/Realm.h>

@interface ProcessModel : RLMObject

@property NSString *identifier;
@property NSString *remoteEndpoint;
@property NSString *bundleIdentifier;
@property BOOL allowed;

@end

#endif /* ProcessModel_h */
