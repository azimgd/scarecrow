//
//  Validator.h
//  scarecrow
//
//  Created by azim on 29.09.2023.
//

#ifndef Validator_h
#define Validator_h

@interface Validator : NSObject

@property (class, nonatomic, readonly) Validator *shared;
@property (nonatomic, readwrite) NSMutableDictionary *rules;

- (void)handleFlowRuleUpdate:(NSNotification *)sender;

@end

#endif /* Validator_h */
