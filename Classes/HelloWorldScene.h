//
//  HelloWorldLayer.h
//  DragDrop
//



// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorld Layer
@interface HelloWorld : CCLayer
{
    CCSprite * background;
    CCSprite * selSprite;
    NSMutableArray * movableSprites;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
-(void)makepinch:(UIPinchGestureRecognizer*)pinch;

@end