//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CommandData.h"


@implementation CommandData {

}

@synthesize commandId = _commandId;
@synthesize messageData = _messageData;

- (id)initWithId:(NSString *)id1 andData:(NSDictionary *)data {
    self = [self init];
    if (self) {
        _commandId = id1;
        _messageData = data;
    }
    return self;
}


@end