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
- (void)updateFlowRule:(NSString *)bundleIdentifier payload:(BOOL)payload;
@end

// Extension -> Host
@protocol HostCommunicationProtocol
- (void)startConnection;
- (void)stopConnection;
- (void)handleDataFromFlowEvent:(NSDictionary *)payload;
- (void)updateFlowRule:(NSString *)bundleIdentifier payload:(BOOL)payload;
@end

#endif /* CommunicationProtocol_h */
