//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SRWebSocketExtension.h"


@implementation SRWebSocket (SRWebSocketExtension)


- (void)sendMessage:(NSString *)data withName :(NSString *)name {
    NSString *message = [NSString stringWithFormat:@"[\"%@\",{ \"data\": %@}]", name, data];
    [self send:message];
}


@end