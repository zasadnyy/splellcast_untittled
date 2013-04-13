//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CommunicationManager.h"
#import "SRWebSocket.h"
#import "WebSocketDelegate.h"
#import "SessionInfo.h"
#import "NotificationHelper.h"


@implementation CommunicationManager {
    SRWebSocket *_webSocket;
    SessionInfo *_sessionInfo;
    NSString *_sessionUID;
}
- (id)init {
    self = [super init];
    if (self) {
        _sessionInfo = [[[SessionInfo alloc] init] autorelease];
        _sessionUID = [[NSString alloc] init];
    }
    return self;
}

- (void)startGame {
    [self _reconnect];
}

- (void)restartGame {
    [self _reconnect];
}

- (void)killGame {
    _webSocket.delegate = nil;
    [_webSocket close];
    _webSocket = nil;
}


- (void)_reconnect; {
    _webSocket.delegate = nil;
    [_webSocket close];

    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.1.96:3000/websocket"]]];
    _webSocket.delegate = [[WebSocketDelegate alloc] initWithSocket:_webSocket];

    [_webSocket open];

    [self _registerToGetNotifications];
}

- (void)_registerToGetNotifications {

    NSArray *notificationsNames = [NSArray arrayWithObjects:
            SESSION_UID,
            READY_TO_CONFIRM_ORDER,
            nil];

    for (NSString *notificationName in notificationsNames) {
        [[NSNotificationCenter defaultCenter]
                addObserver:self
                   selector:@selector(useNotificationWithString:)
                       name:notificationName
                     object:nil];
    }

}

- (void)useNotificationWithString:(NSNotification *)notification {

    if ([notification.name isEqualToString:SESSION_UID]) {
//        _sessionInfo.sessionUID = [[NSString alloc] initWithString:notification.object];
        _sessionUID = [[NSString alloc] initWithString:notification.object];
    } else if ([notification.name isEqualToString:READY_TO_CONFIRM_ORDER]) {
        // post order
    } else {
        NSLog([NSString stringWithFormat:@"USE notification %@", notification]);
    }

}

- (void)dealloc {
    [_webSocket release];
    [super dealloc];
}


@end