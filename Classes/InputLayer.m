//
//  InputLayer.m
//  ScrollingWithJoy
//


#import "InputLayer.h"

void drawMapNode(id o);

@interface InputLayer (PrivateMethods)
- (void)addButtons;
@end

@implementation InputLayer

-(NSMutableDictionary *)locations{
    if (!_buttons) {
        _buttons = [[NSMutableDictionary alloc] init];
    }
    return _buttons;
}

-(id) init
{
	if ((self = [super init]))
	{
		[self addButtons];

//        UIPanGestureRecognizer *gestureRecognizerInput = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)] autorelease];
//        
//        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:gestureRecognizerInput];
        
//		[self scheduleUpdate];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                         priority:-1
                                                  swallowsTouches:YES];
    }
    return self;
}


-(void) setInitialPositions {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    NSArray *sprites = [self.locations allKeys];
    int i = 0;
    for (NSString *name in sprites) {
        CCSprite *sprite = [self.locations valueForKey:name];
        float offsetFraction = ((float) (i + 1)) / (sprites.count + 1);
        sprite.position = ccp(winSize.width * offsetFraction, 32.0f);
        i++;
    }
}

- (void)doSomethingOne:(CCMenuItem *)menuItem {
    NSLog(@"The first menu was called");
}

- (void)doSomethingThree:(CCMenuItem *)menuItem {
    NSLog(@"The third menu was called");
}

- (void)doSomethingFour:(CCMenuItem *)menuItem {
    NSLog(@"The four menu was called");
}

- (void)doSomethingFive:(CCMenuItem *)menuItem {
    NSLog(@"The five menu was called");
}

-(void) addButtons
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
//    NSArray *units = [NSArray arrayWithObjects:
//                      @"Soldier_P1.png", @"Tank_P1.png",
//
//    CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, nil];
//    
//    NSArray *units = [NSArray arrayWithObjects:
//                      @"Soldier_P1.png", @"Tank_P1.png",
//                      @"HQ_P1.png", @"Cannon_P1.png", nil];
//    for (int i = 0; i < units.count; ++i) {
//        NSString *image = [units objectAtIndex:i];
//        CCSprite *sprite = [CCSprite spriteWithFile:image];
//        float offsetFraction = ((float) (i + 1)) / (units.count + 1);
//        sprite.position = ccp(winSize.width * offsetFraction, 32.0f);
//        [self addChild:sprite];
//        [self.buttons setObject:sprite forKey:image];
//    }
    
    CCMenuItemImage *commit = [CCMenuItemImage itemFromNormalImage:@"Icon.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingOne:)];
    CCMenuItemImage *attack = [CCMenuItemImage itemFromNormalImage:@"Icon.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingOne:)];
    CCMenuItemImage *defence = [CCMenuItemImage itemFromNormalImage:@"Icon.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingOne:)];
    CCMenuItemImage *support = [CCMenuItemImage itemFromNormalImage:@"Icon.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingOne:)];
    
	CCMenu * myMenu = [CCMenu menuWithItems:commit, attack, defence, support, nil];
    [myMenu alignItemsHorizontally];
    myMenu.anchorPoint = CGPointZero;
    myMenu.position = ccp(winSize.width * 0.5, 32.0f);

    [self addChild:myMenu];
}


- (void)update:(ccTime)delta {

}


- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCSprite *newSprite = nil;
    NSArray *sprites = [self.locations allKeys];
    for (NSString *name in sprites) {
        CCSprite *sprite = [self.locations valueForKey:name];
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            newSprite = sprite;
            break;
        }
    }
    if (newSprite != selSprite) {
        [selSprite stopAllActions];
        [selSprite runAction:[CCRotateTo actionWithDuration:0.1 angle:0]];
        CCRotateTo *rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
        CCRotateTo *rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
        CCRotateTo *rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
        CCSequence *rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        [newSprite runAction:[CCRepeatForever actionWithAction:rotSeq]];
        selSprite = newSprite;
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}

- (void)panForTranslation:(CGPoint)translation {
    if (selSprite) {
        CGPoint newPos = ccpAdd(selSprite.position, translation);
        selSprite.position = newPos;
    }
//    else {
//        CGPoint newPos = ccpAdd(self.position, translation);
//        self.position = newPos;
//    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}
//
//- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
//    
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        
//        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
//        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
//        touchLocation = [self convertToNodeSpace:touchLocation];
//        
//        [self selectSpriteForTouch:touchLocation];
//        
//    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
//        
//        CGPoint translation = [recognizer translationInView:recognizer.view];
//        translation = ccp(translation.x, -translation.y);
//        [self panForTranslation:translation];
//        [recognizer setTranslation:CGPointZero inView:recognizer.view];
//    }
//}

@end
