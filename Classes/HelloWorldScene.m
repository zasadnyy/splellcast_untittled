//
//  HelloWorldLayer.m
//  DragDrop
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "InputLayer.h"
#import "NotificationHelper.h"
#import "World.h"
#import "Order.h"
// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer z:0];
    
    InputLayer* inputLayer = [InputLayer node];
    [scene addChild:inputLayer z:1];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init {
    if((self = [super init])) {		
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"background.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        movableUnits = [[NSMutableArray alloc] init];
        NSArray *units = [NSArray arrayWithObjects:
                          @"Soldier_P1.png", @"Tank_P1.png",
                          @"HQ_P1.png",@"Cannon_P1.png",
                          @"Soldier_P1.png", @"Tank_P1.png",
                          @"HQ_P1.png", @"Cannon_P1.png", nil];
        for(int i = 0; i < units.count; ++i) {
            NSString *image = [units objectAtIndex:i];
            CCSprite *sprite = [CCSprite spriteWithFile:image];
            float offsetFraction = ((float)(i+10))/(units.count+1);
            sprite.position = ccp(winSize.width*offsetFraction, winSize.height/2);
            [self addChild:sprite];
            [movableUnits addObject:sprite];
        }
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(makepinch:)];
        
        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:pinch];
        
        UIPanGestureRecognizer *gestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)] autorelease];
        
        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:gestureRecognizer];

        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        [self _registerToGetNotifications];
        
    }
    return self;
}

-(void) setUnits: (NSDictionary *)units {
    for (id unit in [units allKeys]) {
        if ([unit isKindOfClass:[NSString class]]) {
            CCSprite *sprite = [CCSprite spriteWithFile:(NSString *)unit];
            sprite.position = [[units objectForKey:unit] CGPointValue];
            [self addChild:sprite];
            [movableUnits addObject:sprite];
        }
    }
}

-(void)makepinch:(UIPinchGestureRecognizer*)pinch
{
//    if(pinch.state == UIGestureRecognizerStateEnded)
//    {
//        self.scale = pinch.scale;
//    }
//    else if(pinch.state == UIGestureRecognizerStateBegan && self.scale != 0.0f)
//    {
//        
//        pinch.scale = self.scale;
//    }
//    if(pinch.scale != NAN && pinch.scale != 0.0)
//    {
//        pinch.view.transform = CGAffineTransformMakeScale(pinch.scale, pinch.scale);
//    }
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[movableUnits release];
    movableUnits = nil;
	[super dealloc];
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCSprite * newSprite = nil;
    for (CCSprite *sprite in movableUnits) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {            
            newSprite = sprite;
            break;
        }
    }    
    if (newSprite != selSprite) {
        [selSprite stopAllActions];
        [selSprite runAction:[CCRotateTo actionWithDuration:0.1 angle:0]];
        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
        CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        [newSprite runAction:[CCRepeatForever actionWithAction:rotSeq]];            
        selSprite = newSprite;
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];      
    return TRUE;    
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -background.contentSize.width+winSize.width);
//    retval.y = self.position.y;
    retval.y = MIN(retval.y, 0);
    retval.y = MAX(retval.y, -background.contentSize.height+winSize.height);
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {    
    if (selSprite) {
        CGPoint newPos = ccpAdd(selSprite.position, translation);
        selSprite.position = newPos;
    } else {
        CGPoint newPos = ccpAdd(self.position, translation);
        self.position = [self boundLayerPos:newPos];      
    }  
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {       
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);    
    [self panForTranslation:translation];    
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {    
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];                
        [self selectSpriteForTouch:touchLocation];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {    
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = ccp(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];    
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (!selSprite) {         
            float scrollDuration = 0.2;
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            CGPoint newPos = ccpAdd(self.position, ccpMult(velocity, scrollDuration));
            newPos = [self boundLayerPos:newPos];
            
            [self stopAllActions];
            CCMoveTo *moveTo = [CCMoveTo actionWithDuration:scrollDuration position:newPos];            
            [self runAction:[CCEaseOut actionWithAction:moveTo rate:1]];            
        }        
        
    }        
}



- (void)_registerToGetNotifications {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(processNewWorld:)
     name:WORLD_OBJECT_ARRIVED
     object:nil];
    
}

- (void)processNewWorld:(NSNotification *)notification {
    World *newWorld = notification.object;
    
    // render world
}

- (void)postOrder:(Order *)order {
    [NotificationHelper postNotificationWithName:READY_TO_CONFIRM_ORDER andObject:order];
}


@end
