//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SessionInfo.h"


@implementation SessionInfo {

}

@synthesize sessionUID = _sessionUID;

- (id)init {
    self = [super init];
    if (self) {
        _sessionUID = [[NSString alloc] init];
    }
    return self;
}


@end