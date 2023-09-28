//
//  HostCommunicationDelegate.h
//  scarecrow
//
//  Created by azim on 23.09.2023.
//

#ifndef HostCommunicationDelegate_h
#define HostCommunicationDelegate_h

#import "CommunicationProtocol.h"

@interface HostCommunicationDelegate : NSObject <HostCommunicationProtocol>

@property (class, nonatomic, readonly) HostCommunicationDelegate *shared;

@end

#endif /* HostCommunicationDelegate_h */
