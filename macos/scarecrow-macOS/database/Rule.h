//
//  Rule.h
//  scarecrow
//
//  Created by azim on 02.10.2023.
//

#ifndef Rule_h
#define Rule_h

#import <Realm/Realm.h>

@interface Rule : RLMObject

@property NSString *identifier;
@property NSString *remoteEndpoint;
@property NSString *bundleIdentifier;
@property BOOL allowed;

@end

#endif /* Rule_h */
