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
- (void)initialize;
@end

// Extension -> Host
@protocol HostCommunicationProtocol
- (void)logger:(NSString *)payload;
@end

#endif /* CommunicationProtocol_h */