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
- (void)startConnection;
- (void)stopConnection;
@end

// Extension -> Host
@protocol HostCommunicationProtocol
- (void)startConnection;
- (void)stopConnection;
- (void)handleDataFromFlowEvent:(NSDictionary *)payload;
- (void)validateRuleForFlowEvent:(NSDictionary *)payload withCallback:(void(^)(BOOL allowed))callback;
- (void)toggleFlowRule:(NSString *)bundleIdentifier withCallback:(void(^)(BOOL status))callback;
@end

#endif /* CommunicationProtocol_h */
