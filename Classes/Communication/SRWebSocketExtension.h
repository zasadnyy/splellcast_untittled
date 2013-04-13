//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SRWebSocket.h"


@interface SRWebSocket (SRWebSocketExtension)

-(void) sendMessage:(NSString *)data withName:(NSString *)name;

@end