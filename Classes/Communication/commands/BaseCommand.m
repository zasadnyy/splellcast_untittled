//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaseCommand.h"
#import "CommandData.h"


@implementation BaseCommand {

}

@synthesize commandId = _commandId;

- (id)initWithName:(NSString *)id {
    self = [super init];
    if (self) {
        _commandId = id;
    }
    return self;
}

- (BOOL)process:(CommandData *)data {
    return NO;
}


@end