//
//  Process.h
//  scarecrow
//
//  Created by azim on 05.10.2023.
//

#ifndef Process_h
#define Process_h

#import <Realm/Realm.h>

@interface Process : RLMObject

@property NSString *identifier;
@property NSString *remoteEndpoint;
@property NSString *bundleIdentifier;
@property BOOL allowed;

@end

#endif /* Process_h */
