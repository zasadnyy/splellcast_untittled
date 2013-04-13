//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AddPlayerRequest.h"


@implementation AddPlayerRequest {

}
- (id)init {
    return [super initWithName:@"add_player"];
}


- (NSString *)build {
    u_int32_t i = arc4random_uniform(74);
    NSString *data = [NSString stringWithFormat:@"{\"username\": \"vasia\", \"key\": \"askjdfg237t8aa%i\"}", i];
    return data;
}


@end