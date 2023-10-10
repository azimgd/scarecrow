//
//  HostCommunication.m
//  scarecrow
//
//  Created by azim on 12.09.2023.
//

#import <Foundation/Foundation.h>
#import "HostCommunication.h"

@implementation HostCommunication

static HostCommunication *sharedInstance = nil;

+ (HostCommunication *)shared
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[HostCommunication alloc] init];
  });
  return sharedInstance;
}

- (void)handleConnectionStart
{
  NSXPCConnection *newConnection = [[NSXPCConnection alloc] initWithMachServiceName:@"B6BB88CAP5.com.azimgd.scarecrow.scarecrow-network" options:0];
 
  newConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ExtensionCommunicationProtocol)];
  newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(HostCommunicationProtocol)];
  newConnection.exportedObject = sharedInstance;
  
  [newConnection resume];
  sharedInstance.connection = newConnection;
  
  [sharedInstance.connection.remoteObjectProxy handleConnectionStart];
}

- (void)handleConnectionStop
{
  [sharedInstance.connection.remoteObjectProxy handleConnectionStop];
  [sharedInstance.connection suspend];
}

- (void)handleFlowRequest:(NSDictionary *)flowPayload processPayload:(NSDictionary *)processPayload
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"handleFlowRequest" object:nil userInfo:@{
    @"flow": flowPayload,
    @"process": processPayload,
  }];
}

- (void)handleFlowRuleUpdate:(NSString *)bundleIdentifier payload:(BOOL)payload
{
  [sharedInstance.connection.remoteObjectProxy handleFlowRuleUpdate:bundleIdentifier payload:payload];
}

@end
