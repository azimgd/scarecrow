//
//  Flow.h
//  scarecrow-macOS
//
//  Created by azim on 19.09.2023.
//

#ifndef Flow_h
#define Flow_h

#import <Realm/Realm.h>

@interface Flow : RLMObject
  @property NSString * _id;
  @property NSString *direction;
  @property NSString *remoteEndpoint;
  @property NSString *remoteUrl;
  @property NSString *localizedName;
  @property NSString *bundleIdentifier;
  
  - (NSDictionary *)payload;
@end

#endif /* Flow_h */
