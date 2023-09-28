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

  @property (nonatomic, copy) void (^enableCallback)(void);
  @property (nonatomic, copy) void (^disableCallback)(void);


  - (void)enable:(void(^)(void))callback;
  - (void)disable:(void(^)(void))callback;;
  - (void)status:(void(^)(BOOL status))callback;
@end

#endif /* FilterDataExtensionProvider_h */
