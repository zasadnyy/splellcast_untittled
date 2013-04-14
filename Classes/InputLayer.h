//
//  InputLayer.h
//  ScrollingWithJoy
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface InputLayer : CCLayer 
{
    CCSprite * selSprite;
}

@property (nonatomic, strong) NSMutableDictionary * buttons;
-(void) setInitialPositions;

@end
