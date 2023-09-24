//
//  HostCommunicationDelegate.h
//  scarecrow
//
//  Created by azim on 23.09.2023.
//

#ifndef HostCommunicationDelegate_h
#define HostCommunicationDelegate_h

@protocol HostCommunicationDelegateProtocol
@end

@interface HostCommunicationDelegate : NSObject <HostCommunicationDelegateProtocol>
@property (class, nonatomic, readonly) HostCommunicationDelegate *shared;

- (void)handleDataFromFlowEvent:(NSDictionary *)payload;
- (void)validateRuleForFlowEvent:(NSDictionary *)payload withCallback:(void(^)(BOOL allowed))callback;
- (void)toggleFlowRule:(NSString *)bundleIdentifier;

@end

#endif /* HostCommunicationDelegate_h */
