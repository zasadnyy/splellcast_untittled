//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HandshakeCommand.h"
#import "CommandData.h"
#import "NotificationHelper.h"


@implementation HandshakeCommand {

}

- (id)init {
    self = [super initWithName:@"handshake"];
    return self;
}


- (BOOL)process:(CommandData *)data {

    NSString *sessionUid = [data.messageData valueForKey:@"session_uid"];
    [NotificationHelper postNotificationWithName:SESSION_UID andObject:sessionUid];

    return YES;
}


@end