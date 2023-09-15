//
//  main.m
//  scarecrow-network
//
//  Created by azim on 15.09.2023.
//

#import <Foundation/Foundation.h>
#import <NetworkExtension/NetworkExtension.h>

int main(int argc, char *argv[])
{
    @autoreleasepool {
        [NEProvider startSystemExtensionMode];
    }
    
    dispatch_main();
}
