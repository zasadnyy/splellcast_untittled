//
//  HelloWorldLayer.h
//  DragDrop
//


#import "cocos2d.h"

@interface HelloWorld : CCLayer
{
    CCSprite * background;
    CCSprite * selSprite;
    NSMutableArray * movableUnits;
}

+(id) scene;
-(void)makepinch:(UIPinchGestureRecognizer*)pinch;

@end
