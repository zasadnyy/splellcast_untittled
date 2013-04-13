//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaseRequest.h"


@implementation BaseRequest {

}

@synthesize requestName = _requestName;

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _requestName = name;
    }
    return self;
}

- (NSString *)build {
    return @"{}";
}


@end