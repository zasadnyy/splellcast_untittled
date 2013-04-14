//
// Created by vitaliyzasadnyy on 14.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RandomHelper.h"


@implementation RandomHelper {

}

+ (int)getRandomNumberBetween:(int)from to:(int)to {
    return (int) from + arc4random() % (to - from + 1);
}

@end