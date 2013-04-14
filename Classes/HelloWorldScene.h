//
//  HelloWorldLayer.h
//  DragDrop
//


#import "cocos2d.h"

@class MapData;

@interface HelloWorld : CCLayer
{
    CCSprite * background;
    CCSprite * selSprite;
    NSMutableArray * locations;
}

@property(strong, nonatomic) MapData *mapData;

+(id) scene;
-(void)makepinch:(UIPinchGestureRecognizer*)pinch;

@end
