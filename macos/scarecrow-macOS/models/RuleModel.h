//
//  RuleModel.h
//  scarecrow
//
//  Created by azim on 02.10.2023.
//

#ifndef RuleModel_h
#define RuleModel_h

#import <Realm/Realm.h>

@interface RuleModel : RLMObject

@property NSString *identifier;
@property NSString *remoteEndpoint;
@property NSString *bundleIdentifier;
@property BOOL allowed;

@end

#endif /* RuleModel_h */
