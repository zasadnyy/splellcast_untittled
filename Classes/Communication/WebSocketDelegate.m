//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "WebSocketDelegate.h"
#import "SRWebSocketExtension.h"


@implementation WebSocketDelegate {

}
- (id)initWithSocket:(SRWebSocket *)webSocket {
    _webSocket = webSocket;
    return self;
}


- (void)webSocketDidOpen:(SRWebSocket *)webSocket; {
    NSLog(@"Websocket Connected");
    [_webSocket sendMessage:@"{\"username\": \"vasia\", \"key\": \"askjdfg237t8aa\"}" withName:@"add_player"];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error; {
    NSLog(@":( Websocket Failed With Error %@", error);

    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message; {
    NSLog(@"Received \"%@\"", message);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean; {
    NSLog(@"WebSocket closed");
    _webSocket = nil;
}


@end