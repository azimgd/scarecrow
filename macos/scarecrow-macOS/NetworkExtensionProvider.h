//
//  FilterDataExtensionProvider.h
//  scarecrow
//
//  Created by azim on 11.09.2023.
//

#ifndef NetworkExtensionProvider_h
#define NetworkExtensionProvider_h

#import <SystemExtensions/SystemExtensions.h>
#import <NetworkExtension/NetworkExtension.h>

@interface NetworkExtensionProvider : NSObject<OSSystemExtensionRequestDelegate>
  @property (class, nonatomic, readonly) NetworkExtensionProvider *shared;
  @property (nonatomic, assign) BOOL active;

  - (void)handleExtensionStart;
  - (void)handleExtensionStop;
  - (void)handleExtensionStatusRequest:(void(^)(BOOL status))callback;
@end

#endif /* FilterDataExtensionProvider_h */
