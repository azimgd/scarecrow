//
//  ExtensionCommunicationDelegate.m
//  scarecrow
//
//  Created by azim on 12.09.2023.
//

#import <Foundation/Foundation.h>
#import "ExtensionCommunicationDelegate.h"
#import "CommunicationProtocol.h"
#import "ExtensionCommunication.h"

@implementation ExtensionCommunicationDelegate

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection {
  ExtensionCommunication *exportedObject = [ExtensionCommunication shared];

  newConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(HostCommunicationProtocol)];
  newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ExtensionCommunicationProtocol)];
  newConnection.exportedObject = exportedObject;

  [newConnection resume];

  exportedObject.connection = newConnection;

  return YES;
}

@end
