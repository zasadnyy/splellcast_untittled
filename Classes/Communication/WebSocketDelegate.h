//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SRWebSocket.h"

@class CommandProcessor;
@class SessionInfo;


@interface WebSocketDelegate : NSObject <SRWebSocketDelegate> {

}

- (id)initWithSocket:(SRWebSocket *)webSocket;

@end