//
//  CommunicationProtocol.h
//  scarecrow
//
//  Created by azim on 12.09.2023.
//

#ifndef CommunicationProtocol_h
#define CommunicationProtocol_h

// Host -> Extension
@protocol ExtensionCommunicationProtocol
- (void)handleConnectionStart;
- (void)handleConnectionStop;
- (void)handleFlowRuleUpdate:(NSString *)bundleIdentifier payload:(BOOL)payload;
@end

// Extension -> Host
@protocol HostCommunicationProtocol
- (void)handleConnectionStart;
- (void)handleConnectionStop;
- (void)handleFlowRequest:(NSDictionary *)flowPayload processPayload:(NSDictionary *)payload;
- (void)handleFlowRuleUpdate:(NSString *)bundleIdentifier payload:(BOOL)payload;
@end

#endif /* CommunicationProtocol_h */
