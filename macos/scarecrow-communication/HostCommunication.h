//
//  HostCommunication.h
//  scarecrow
//
//  Created by azim on 12.09.2023.
//

#ifndef HostCommunication_h
#define HostCommunication_h

#import "CommunicationProtocol.h"

@interface HostCommunication : NSObject <HostCommunicationProtocol>

@property (class, nonatomic, readonly) HostCommunication *shared;
@property (weak) NSXPCConnection *connection;

- (void)handleConnectionStart;
- (void)handleConnectionStop;

@end

#endif /* HostCommunication_h */
