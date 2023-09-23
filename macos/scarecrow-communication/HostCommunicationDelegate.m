//
//  HostCommunicationDelegate.m
//  scarecrow-macOS
//
//  Created by azim on 23.09.2023.
//

#import <Foundation/Foundation.h>
#import "HostCommunicationDelegate.h"
#import <Realm/Realm.h>
#import "Rule.h"
#import "Flow.h"

@implementation HostCommunicationDelegate

static HostCommunicationDelegate *sharedInstance = nil;

+ (HostCommunicationDelegate *)shared
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[HostCommunicationDelegate alloc] init];
  });
  return sharedInstance;
}

- (void)handleDataFromFlowEvent:(NSDictionary *)payload
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"handleDataFromFlowEvent" object:nil userInfo:payload];

  [self saveFlow:payload];
}

- (void)validateRuleForFlowEvent:(NSDictionary *)payload withCallback:(void(^)(BOOL allowed))callback
{
  NSString *bundleIdentifier = [payload objectForKey:@"bundleIdentifier"];
  callback([self validateFlowForBundleIdentifier:bundleIdentifier]);
}

- (void)saveFlow:(NSDictionary *)payload
{
  Flow *flow = [Flow new];
  RLMRealm *realm = [RLMRealm defaultRealm];
  
  flow._id = [[NSUUID UUID] UUIDString];
  flow.direction = [payload objectForKey:@"direction"];
  flow.remoteEndpoint = [payload objectForKey:@"remoteEndpoint"];
  flow.remoteUrl = [payload objectForKey:@"remoteUrl"];
  flow.localizedName = [payload objectForKey:@"localizedName"];
  flow.bundleIdentifier = [payload objectForKey:@"bundleIdentifier"];
  
  [realm transactionWithBlock:^{
    [realm addObject:flow];
  }];
}

- (BOOL)validateFlowForBundleIdentifier:(NSString *)bundleIdentifier
{
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults<Rule *> *results = [Rule allObjectsInRealm:realm];
  RLMResults<Rule *> *distinctResults = [results objectsWithPredicate:[NSPredicate predicateWithFormat:@"bundleIdentifier == %@", bundleIdentifier]];
  
  return (!distinctResults.count || [distinctResults firstObject].allowed);
}

@end
