//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface NotificationHelper : NSObject

+ (void)postNotificationWithName:(NSString *)name andObject:(id)object;

+ (void)postNotification:(NSNotification *)notification;

@end


extern NSString *const SESSION_UID;
extern NSString *const WORLD_OBJECT_ARRIVED;
extern NSString *const READY_TO_CONFIRM_ORDER;