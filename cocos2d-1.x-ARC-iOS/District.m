/* 
 * District of cocos2d-1.x-ARC-iOS.
 *
 * Designed+Engineered by DEVKID on Sat, Apr 13, 13 1:25 PM.
 * Copyright © 2013 DEVKID. All rights reserved.
 *
 * #def WORLD PLAYGROUND
 */

#import "District.h"


@implementation District
{
    CCSprite *background;
}

-(id) init
{
    self = [super init];
    if (self) {
        background = [CCSprite spriteWithFile:@"0-0-ipad"];
        [self addChild:background];

    }

    return self;
}
@end