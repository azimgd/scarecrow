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

- (void)handleDataFromFlowEvent:(NSDictionary *)payload
{
  [[self delegate] handleDataFromFlowEvent:payload];
}

- (void)validateRuleForFlowEvent:(NSDictionary *)payload withCallback:(void(^)(BOOL allowed))callback
{
  [[self delegate] validateRuleForFlowEvent:payload withCallback:callback];
}

- (void)toggleFlowRule:(NSString *)bundleIdentifier withCallback:(void(^)(BOOL status))callback
{
  [[self delegate] toggleFlowRule:bundleIdentifier withCallback:callback];
}

@end
