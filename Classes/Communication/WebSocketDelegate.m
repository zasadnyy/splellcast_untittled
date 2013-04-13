//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "WebSocketDelegate.h"
#import "SRWebSocketExtension.h"
#import "CommandProcessor.h"
#import "AddPlayerRequest.h"


@implementation WebSocketDelegate {
    SRWebSocket *_webSocket;
    CommandProcessor *_processor;
}
- (id)initWithSocket:(SRWebSocket *)webSocket {
    self = [super init];
    if (self) {
        _webSocket = webSocket;
        _processor = [[CommandProcessor alloc] init];
    }
    return self;
}


- (void)webSocketDidOpen:(SRWebSocket *)webSocket; {
    NSLog(@"Websocket Connected");
    AddPlayerRequest *initialRequest = [[[AddPlayerRequest alloc] init] autorelease];
    [_webSocket sendMessage:[initialRequest build] withName:[initialRequest requestName]];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error; {
    NSLog(@":( Websocket Failed With Error %@", error);

    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message; {
    NSLog(@"Received \"%@\"", message);
    [_processor processMessage:message];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean; {
    NSLog(@"WebSocket closed");
    _webSocket = nil;
}

- (void)dealloc {
    [_processor release];
    [super dealloc];
}


@end