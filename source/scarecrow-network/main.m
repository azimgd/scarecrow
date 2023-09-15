//
//  main.m
//  scarecrow-filter-data
//
//  Created by azim on 11.09.2023.
//

#import <Foundation/Foundation.h>
#import <NetworkExtension/NetworkExtension.h>
#import "ExtensionCommunicationDelegate.h"

int main(int argc, char *argv[])
{
  @autoreleasepool {
    [NEProvider startSystemExtensionMode];
    
    ExtensionCommunicationDelegate *CommunicationDelegate = [ExtensionCommunicationDelegate new];
    NSXPCListener *listener = [[NSXPCListener alloc] initWithMachServiceName:@"B6BB88CAP5.com.azimgd.scarecrow.scarecrow-filter-data"];

    listener.delegate = CommunicationDelegate;
    [listener resume];

    [[NSRunLoop mainRunLoop] run];
  }
  
  dispatch_main();
}
