//
//  HostCommunication.h
//  scarecrow
//
//  Created by azim on 12.09.2023.
//

#ifndef HostCommunication_h
#define HostCommunication_h

#import "CommunicationProtocol.h"
#import "HostCommunicationDelegate.h"

@interface HostCommunication : NSObject <HostCommunicationProtocol>

@property (class, nonatomic, readonly) HostCommunication *shared;
@property (weak) NSXPCConnection *connection;
@property (weak) HostCommunicationDelegate *delegate;

- (void)initialize:(void(^)(void))callback;
- (void)terminate:(void(^)(void))callback;

@end

#endif /* HostCommunication_h */
