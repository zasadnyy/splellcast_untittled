//
//  HelloWorldLayer.m
//  DragDrop
//


#import "HelloWorldScene.h"
#import "InputLayer.h"
#import "NotificationHelper.h"
#import "WorldObj.h"
#import "OrderObj.h"
#import "MapNode.h"
#import "MapData.h"
#include "SimpleAudioEngine.h" 


@implementation HelloWorld {
    NSDictionary *_nodeTypeSpriteMappingOwl;
    NSDictionary *_nodeTypeSpriteMappingBunnies;
    NSDictionary *_nodeTypeSpriteMappingNone;
}

@synthesize mapData = _mapData;

+ (id)scene {
    CCScene *scene = [CCScene node];

    HelloWorld *layer = [HelloWorld node];

    [scene addChild:layer z:0];

    InputLayer *inputLayer = [InputLayer node];
    [scene addChild:inputLayer z:1];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"game.mp3"];

//    UITapGestureRecognizer *gestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:scene action:@selector(handlePanFrom:)] autorelease];
//     [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:gestureRecognizer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;

        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"background.png"];
        background.anchorPoint = ccp(0, 0);
        [self addChild:background];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];

//        movableUnits = [[NSMutableArray alloc] init];
//        NSArray *units = [NSArray arrayWithObjects:
//                @"Soldier_P1.png", @"Tank_P1.png",
//                @"HQ_P1.png", @"Cannon_P1.png",
//                @"Soldier_P1.png", @"Tank_P1.png",
//                @"HQ_P1.png", @"Cannon_P1.png", nil];
//        for (int i = 0; i < units.count; ++i) {
//            NSString *image = [units objectAtIndex:i];
//            CCSprite *sprite = [CCSprite spriteWithFile:image];
//            float offsetFraction = ((float) (i + 10)) / (units.count + 1);
//            sprite.position = ccp(winSize.width * offsetFraction, winSize.height / 2);
//            [self addChild:sprite];
//            [movableUnits addObject:sprite];
//        }

        [self initMappings];
        _mapData = [[MapData alloc] init];
        [self drawMapNodes:_mapData];

        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(makepinch:)];

        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:pinch];

        UIPanGestureRecognizer *gestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)] autorelease];

        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:gestureRecognizer];

        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        [self _registerToGetNotifications];

    }
    return self;
}

- (void)initMappings {
    _nodeTypeSpriteMappingOwl = [NSDictionary dictionaryWithObjectsAndKeys:@"owl_capital.png", NODE_TYPE_CAPITAL, @"owl_large_castle.png", NODE_TYPE_LARGE_CASTLE, @"owl_small_castle.png", NODE_TYPE_SMALL_CASTLE, @"owl_no_castle.png", NODE_TYPE_NO_CASTLE, nil];
    _nodeTypeSpriteMappingBunnies = [NSDictionary dictionaryWithObjectsAndKeys:@"bunnies_capital.png", NODE_TYPE_CAPITAL, @"bunnies_large_castle.png", NODE_TYPE_LARGE_CASTLE, @"bunnies_small_castle.png", NODE_TYPE_SMALL_CASTLE, @"bunnies_no_castle.png", NODE_TYPE_NO_CASTLE, nil];
    _nodeTypeSpriteMappingNone = [NSDictionary dictionaryWithObjectsAndKeys:@"none_capital.png", NODE_TYPE_CAPITAL, @"none_large_castle.png", NODE_TYPE_LARGE_CASTLE, @"none_small_castle.png", NODE_TYPE_SMALL_CASTLE, @"none_no_castle.png", NODE_TYPE_NO_CASTLE, nil];
}


- (void)drawMapNodes:(MapData *)data {
    for (MapNode *node in data.nodes) {
        [self drawMapNode:node];
    }
}

- (void)drawMapNode:(MapNode *)node {

    NSString *imagePath = @"default_node_marker.png";
    if ([NODE_OWNER_BUNNIES isEqualToString:node.owner]) {
        imagePath = [_nodeTypeSpriteMappingBunnies valueForKey:node.nodeType];
    } else if ([NODE_OWNER_OWLS isEqualToString:node.owner]) {
        imagePath = [_nodeTypeSpriteMappingOwl valueForKey:node.nodeType];
    } else if ([NODE_OWNER_NONE isEqualToString:node.owner]) {
        imagePath = [_nodeTypeSpriteMappingNone valueForKey:node.nodeType];
    }

    CCSprite *sprite = [CCSprite spriteWithFile:imagePath];
    sprite.position = ccp(node.coordinate.x, 2048 - node.coordinate.y);
    [self addChild:sprite];
    [locations addObject:sprite];
}


- (void)makepinch:(UIPinchGestureRecognizer *)pinch {
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


- (void)dealloc {
    [locations release];
    locations = nil;
    [super dealloc];
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCSprite *newSprite = nil;
    for (CCSprite *sprite in locations) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            newSprite = sprite;
             NSLog(@"TOUCH");
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

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -background.contentSize.width + winSize.width);
//    retval.y = self.position.y;
    retval.y = MIN(retval.y, 0);
    retval.y = MAX(retval.y, -background.contentSize.height + winSize.height);
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

//    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
//
//        if (!selSprite) {
//            float scrollDuration = 0.2;
//            CGPoint velocity = [recognizer velocityInView:recognizer.view];
//            CGPoint newPos = ccpAdd(self.position, ccpMult(velocity, scrollDuration));
//            newPos = [self boundLayerPos:newPos];
//
//            [self stopAllActions];
//            CCMoveTo *moveTo = [CCMoveTo actionWithDuration:scrollDuration position:newPos];
//            [self runAction:[CCEaseOut actionWithAction:moveTo rate:1]];
//        }

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
    WorldObj *newWorld = notification.object;

    // render world
}

- (void)postOrder:(OrderObj *)order {
    [NotificationHelper postNotificationWithName:READY_TO_CONFIRM_ORDER andObject:order];
}


@end
