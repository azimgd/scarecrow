//
//  FilterDataExtensionProvider.m
//  scarecrow
//
//  Created by azim on 11.09.2023.
//

#import <Foundation/Foundation.h>
#import "NetworkExtensionProvider.h"

#import "CommunicationProtocol.h"
#import "HostCommunication.h"

NSString *const networkExtensionBundleId = @"com.azimgd.scarecrow.scarecrow-network";

@implementation NetworkExtensionProvider

static NetworkExtensionProvider *sharedInstance = nil;

+ (NetworkExtensionProvider *)shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[NetworkExtensionProvider alloc] init];
  });
  return sharedInstance;
}

- (void)enable
{
  OSSystemExtensionRequest *activateSystemRequest = [OSSystemExtensionRequest
    activationRequestForExtension:networkExtensionBundleId
    queue:dispatch_get_main_queue()
  ];
  
  activateSystemRequest.delegate = self;
  [OSSystemExtensionManager.sharedManager submitRequest:activateSystemRequest];
}

- (void)disable
{
  OSSystemExtensionRequest *deactivateSystemRequest = [OSSystemExtensionRequest
    deactivationRequestForExtension:networkExtensionBundleId
    queue:dispatch_get_main_queue()
  ];

  deactivateSystemRequest.delegate = self;
  [OSSystemExtensionManager.sharedManager submitRequest:deactivateSystemRequest];
}

#pragma OSSystemExtensionRequestDelegate

- (OSSystemExtensionReplacementAction)request:(nonnull OSSystemExtensionRequest *)request
  actionForReplacingExtension:(nonnull OSSystemExtensionProperties *)existing
  withExtension:(nonnull OSSystemExtensionProperties *)ext
{
  return OSSystemExtensionReplacementActionReplace;
}

- (void)request:(nonnull OSSystemExtensionRequest *)request
  didFailWithError:(nonnull NSError *)error
{
  NSLog(@"[scarecrow] ext-load: %@", error);
}

- (void)request:(nonnull OSSystemExtensionRequest *)request didFinishWithResult:(OSSystemExtensionRequestResult)result
{
  [NEFilterManager.sharedManager loadFromPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
      NSLog(@"[scarecrow] ext-load: %@", error);
      return;
    }
    
    NEFilterProviderConfiguration* configuration = [[NEFilterProviderConfiguration alloc] init];
    configuration.filterPackets = false;
    configuration.filterDataProviderBundleIdentifier = networkExtensionBundleId;
    configuration.filterSockets = true;
    configuration.filterPacketProviderBundleIdentifier = networkExtensionBundleId;
    
    NEFilterManager.sharedManager.localizedDescription = networkExtensionBundleId;
    NEFilterManager.sharedManager.providerConfiguration = configuration;

    NEFilterManager.sharedManager.enabled = true;

    [NEFilterManager.sharedManager saveToPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
      [[HostCommunication shared] initialize];
    }];
  }];
}

- (void)requestNeedsUserApproval:(nonnull OSSystemExtensionRequest *)request {
}

@end