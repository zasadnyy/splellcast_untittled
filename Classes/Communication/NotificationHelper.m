//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NotificationHelper.h"


@implementation NotificationHelper {

}

+ (void)postNotificationWithName:(NSString *)name andObject:(id)object {
    NSNotification *notification = [NSNotification notificationWithName:name object:object userInfo:nil];
    [NotificationHelper postNotification:notification];
}

+ (void)postNotification:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end

NSString *const SESSION_UID = @"session_uid";
NSString *const WORLD_OBJECT_ARRIVED = @"world_object";
NSString *const READY_TO_CONFIRM_ORDER = @"ready_to_post_order";