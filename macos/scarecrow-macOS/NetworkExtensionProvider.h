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

  - (void)enable;
  - (void)disable;
@end

#endif /* FilterDataExtensionProvider_h */
