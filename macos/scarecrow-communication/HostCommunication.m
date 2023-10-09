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

- (void)startConnection
{
  NSXPCConnection *newConnection = [[NSXPCConnection alloc] initWithMachServiceName:@"B6BB88CAP5.com.azimgd.scarecrow.scarecrow-network" options:0];
 
  newConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ExtensionCommunicationProtocol)];
  newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(HostCommunicationProtocol)];
  newConnection.exportedObject = [HostCommunication shared];
  
  [newConnection resume];
  [HostCommunication shared].connection = newConnection;
  
  [[[HostCommunication shared].connection remoteObjectProxy] startConnection];
}

- (void)stopConnection
{
  [[[HostCommunication shared].connection remoteObjectProxy] stopConnection];
  [[HostCommunication shared].connection suspend];
}

- (void)handleDataFromFlowEvent:(NSDictionary *)flowPayload processPayload:(NSDictionary *)processPayload
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"handleDataFromFlowEvent" object:nil userInfo:@{
    @"flow": flowPayload,
    @"process": processPayload,
  }];
}

- (void)updateFlowRule:(NSString *)bundleIdentifier payload:(BOOL)payload
{
  [[[HostCommunication shared].connection remoteObjectProxy] updateFlowRule:bundleIdentifier payload:payload];
}

@end
