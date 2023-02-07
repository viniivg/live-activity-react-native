//
//  RCTLiveActivityModule.m
//  notificationApp
//
//  Created by Vinícius Guedes on 04/02/23.
//

#import <React/RCTBridgeModule.h>


@interface RCT_EXTERN_MODULE(RCTLiveActivityModule, NSObject);

RCT_EXTERN_METHOD(startNotification:(NSString*) restaurant withOrder:(NSString*) order withStatus:(NSString*) status withDescription:(NSString*) description withStep:(CGFloat*) step withStepMesage:(NSString*) stepMesage withImageStep:(NSString*) imageStep)
RCT_EXTERN_METHOD(updateNotification: (NSString*) status withDescription:(NSString*) description withStep:(CGFloat*) step withStepMesage:(NSString*) stepMesage withImageStep:(NSString*) imageStep)
RCT_EXTERN_METHOD(cancelNotification: (NSString*) status withDescription:(NSString*) description withStep:(CGFloat*) step withStepMesage:(NSString*) stepMesage withImageStep:(NSString*) imageStep)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
