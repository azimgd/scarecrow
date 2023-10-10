//
//  FlowModel.h
//  scarecrow
//
//  Created by azim on 30.09.2023.
//

#ifndef FlowModel_h
#define FlowModel_h

#import <Realm/Realm.h>

@interface FlowModel : RLMObject

@property NSString *direction;
@property NSString *remoteEndpoint;
@property NSString *remoteUrl;
@property NSString *identifier;
@property NSString *name;
@property NSString *bundleIdentifier;
@property NSString *path;

@end

#endif /* FlowModel_h */
