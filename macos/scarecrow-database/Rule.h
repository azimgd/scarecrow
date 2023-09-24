//
//  Rule.h
//  scarecrow
//
//  Created by azim on 23.09.2023.
//

#ifndef Rule_h
#define Rule_h

#import <Realm/Realm.h>

@interface Rule : RLMObject
  @property NSString *bundleIdentifier;
  @property BOOL allowed;

  - (NSDictionary *)payload;
@end


#endif /* Rule_h */
