//
//  Communication.h
//  scarecrow
//
//  Created by azim on 12.09.2023.
//

#ifndef Communication_h
#define Communication_h

#import <Foundation/Foundation.h>
#import <NetworkExtension/NetworkExtension.h>
#import "CommunicationProtocol.h"

@interface ExtensionCommunication : NSObject <ExtensionCommunicationProtocol>
@end

#endif /* Communication_h */
