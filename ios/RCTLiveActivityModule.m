//
//  RCTLiveActivityModule.m
//  notificationApp
//
//  Created by Vinícius Guedes on 04/02/23.
//

#import <React/RCTBridgeModule.h>


@interface RCT_EXTERN_MODULE(RCTLiveActivityModule, NSObject);

RCT_EXTERN_METHOD(startNotification)
RCT_EXTERN_METHOD(updateNotification)
RCT_EXTERN_METHOD(cancelNotification)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
