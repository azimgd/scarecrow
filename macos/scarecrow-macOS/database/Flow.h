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

@property NSString *identifier;
@property NSString *direction;
@property NSString *remoteEndpoint;
@property NSString *remoteUrl;
@property NSString *localizedName;
@property NSString *bundleIdentifier;
@property NSDate *date;
@property NSNumber<RLMFloat> *size;

@end

#endif /* Flow_h */
