//
//  Flow.h
//  scarecrow
//
//  Created by azim on 30.09.2023.
//

#ifndef Flow_h
#define Flow_h

#import <Realm/Realm.h>

@interface Flow : RLMObject

@property NSString *direction;
@property NSString *remoteEndpoint;
@property NSString *remoteUrl;
@property NSString *identifier;
@property NSString *name;
@property NSString *bundleIdentifier;
@property NSString *path;

@end

#endif /* Flow_h */
