//
//  InputLayer.h
//  ScrollingWithJoy
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MapData;

@interface InputLayer : CCLayer 
{
    CCSprite * selSprite;
}

@property (nonatomic, strong) NSMutableDictionary * locations;
@property (nonatomic, strong) MapData *mapData;

-(void) setInitialPositions;

@end
