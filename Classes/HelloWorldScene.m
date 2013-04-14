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
#import "WorldObjWorld.h"
#import "Node.h"
#import "NodeArmy.h"
#import "NodeArmyCrew.h"
#import "RandomHelper.h"
#import "CommunicationManager.h"
#include "SimpleAudioEngine.h" 


double findDistance(CGPoint point1, CGPoint point2) {
    return sqrt(pow((point1.x - point2.x), 2) + pow((point1.y - point2.y), 2));
}

@implementation HelloWorld {
    CommunicationManager *_communicationManager;
    CCSprite *_highlightCastle;
}

@synthesize mapData = _mapData;
@synthesize ownerMapping, nodeTypeSpriteMappingOwl, nodeTypeSpriteMappingBunnies, nodeTypeSpriteMappingNone;

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

        _highlightCastle = [CCSprite spriteWithFile:@"glow.png"];
        _highlightCastle.position = CGPointMake(0, 0);
//        _highlightCastle.visible = NO;
        [self addChild:_highlightCastle];

        [self initMappings];
        self.mapData = [[MapData alloc] init];
        [self drawMapNodes:_mapData];

        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(makepinch:)];

        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:pinch];

        UIPanGestureRecognizer *gestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)] autorelease];

        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:gestureRecognizer];

        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

        _communicationManager = [[CommunicationManager alloc] init];
        [_communicationManager startGame];

        [self _registerToGetNotifications];

    }
    return self;
}

- (void)initMappings {
    self.nodeTypeSpriteMappingOwl = [NSDictionary dictionaryWithObjectsAndKeys:@"owl_capital.png", NODE_TYPE_CAPITAL, @"owl_large_castle.png", NODE_TYPE_LARGE_CASTLE, @"owl_small_castle.png", NODE_TYPE_SMALL_CASTLE, @"owl_no_castle.png", NODE_TYPE_NO_CASTLE, nil];
    self.nodeTypeSpriteMappingBunnies = [NSDictionary dictionaryWithObjectsAndKeys:@"bunnies_capital.png", NODE_TYPE_CAPITAL, @"bunnies_large_castle.png", NODE_TYPE_LARGE_CASTLE, @"bunnies_small_castle.png", NODE_TYPE_SMALL_CASTLE, @"bunnies_no_castle.png", NODE_TYPE_NO_CASTLE, nil];
    self.nodeTypeSpriteMappingNone = [NSDictionary dictionaryWithObjectsAndKeys:@"none_capital.png", NODE_TYPE_CAPITAL, @"none_large_castle.png", NODE_TYPE_LARGE_CASTLE, @"none_small_castle.png", NODE_TYPE_SMALL_CASTLE, @"none_no_castle.png", NODE_TYPE_NO_CASTLE, nil];
    self.ownerMapping = [NSDictionary dictionaryWithObjectsAndKeys:NODE_OWNER_BUNNIES, @"bunnies", NODE_OWNER_OWLS, @"owls", NODE_OWNER_NONE, @"none", nil];
}


- (void)drawMapNodes:(MapData *)data {
    for (MapNode *node in data.nodes) {
        [self drawMapNode:node];
    }
}

- (void)drawMapNode:(MapNode *)node {

    NSString *imagePath = @"default_node_marker.png";
    if ([NODE_OWNER_BUNNIES isEqualToString:node.owner]) {
        imagePath = [self.nodeTypeSpriteMappingBunnies objectForKey:node.nodeType];
    } else if ([NODE_OWNER_OWLS isEqualToString:node.owner]) {
        imagePath = [self.nodeTypeSpriteMappingOwl objectForKey:node.nodeType];
    } else if ([NODE_OWNER_NONE isEqualToString:node.owner]) {
        imagePath = [self.nodeTypeSpriteMappingNone objectForKey:node.nodeType];
    }

    CCSprite *sprite = [CCSprite spriteWithFile:imagePath];
    sprite.position = ccp(node.coordinate.x, 2048 - node.coordinate.y);
    [self addChild:sprite];
    [locations addObject:sprite];

    [self drawArmy:node];
}

- (void)drawArmy:(MapNode *)node {

    NSString *footerImagePath = @"bunny_footer.png";
    NSString *knightImagePath = @"bunny_knight.png";

    if ([NODE_OWNER_OWLS isEqualToString:node.owner]) {
        footerImagePath = @"owl_footer.png";
        knightImagePath = @"owl_knight.png";
    }

    int armyTag = 0x123;
    [self removeChildByTag:armyTag cleanup:YES];

    int to = 0;
    int from = 0;

    int dy = 0;

    for (int i = 0; i < node.footmanNumber.intValue; i++) {
        CCSprite *sprite = [CCSprite spriteWithFile:footerImagePath];
        sprite.tag = armyTag;
        sprite.position = ccp(node.coordinate.x + 20 + i * 20 + [RandomHelper getRandomNumberBetween:from to:to] - node.footmanNumber.intValue * 15, 2048 - node.coordinate.y - 20 - i * dy + [RandomHelper getRandomNumberBetween:from to:to]);
        [self addChild:sprite];
    }

    for (int i = 0; i < node.knightNumber.intValue; i++) {
        CCSprite *sprite = [CCSprite spriteWithFile:knightImagePath];
        sprite.tag = armyTag;
        sprite.position = ccp(node.coordinate.x + 20 + i * 20 + [RandomHelper getRandomNumberBetween:from to:to] - node.knightNumber.intValue * 15, 2048 - node.coordinate.y - 60 - i * dy + [RandomHelper getRandomNumberBetween:from to:to]);
        [self addChild:sprite];
    }

}

- (void)setUnits:(NSDictionary *)units {
    for (id unit in [units allKeys]) {
        if ([unit isKindOfClass:[NSString class]]) {
            CCSprite *sprite = [CCSprite spriteWithFile:(NSString *) unit];
            sprite.position = [[units objectForKey:unit] CGPointValue];
            [self addChild:sprite];
//            [movableUnits addObject:sprite];
        }
    }
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

    double MIN_DISTANCE = 100;

    MapNode *selectedNode = nil;

    for (MapNode *node in self.mapData.nodes) {
        double distance = findDistance(touchLocation, node.coordinate);
        if (distance < MIN_DISTANCE) {
            selectedNode = node;
            break;
        }
    }

    if (selectedNode == nil) {
        NSLog(@"TOUCH TO FAR FROM CASTLES");
//        _highlightCastle.visible = NO;
        return;
    }

    _highlightCastle.position = selectedNode.coordinate;
//    _highlightCastle.visible = YES;


    ///++++++++++++++++++++++++

//    CCSprite *newSprite = nil;
//    for (CCSprite *sprite in locations) {
//        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
//            newSprite = sprite;
//            NSLog(@"TOUCH");
//            break;
//        }
//    }
//    if (newSprite != selSprite) {
//        [selSprite stopAllActions];
//        [selSprite runAction:[CCRotateTo actionWithDuration:0.1 angle:0]];
//        CCRotateTo *rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
//        CCRotateTo *rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
//        CCRotateTo *rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
//        CCSequence *rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
//        [newSprite runAction:[CCRepeatForever actionWithAction:rotSeq]];
//        selSprite = newSprite;
//    }
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
    [self performSelectorOnMainThread:@selector(renderWorldObj:) withObject:newWorld waitUntilDone:YES];
}

- (void)renderWorldObj:(WorldObj *)world {
    [self updateMapData:world];
    [self drawMapNodes:_mapData];
}

- (void)updateMapData:(WorldObj *)newWorld {
    for (Node *node in newWorld.world.nodes) {
        MapNode *nodeToUpdate = [self findMapDataByNodeId:node.nodeId in:_mapData];

        if (nodeToUpdate == nil) {
            return;
        }

        nodeToUpdate.owner = [self.ownerMapping objectForKey:node.owner];
        if ([NODE_OWNER_NONE isEqualToString:nodeToUpdate.owner]) {
            nodeToUpdate.footmanNumber = [NSNumber numberWithInt:0];
            nodeToUpdate.knightNumber = [NSNumber numberWithInt:0];
        } else {
            nodeToUpdate.footmanNumber = node.army.crew.footman;
            nodeToUpdate.knightNumber = node.army.crew.knight;
        }
    }
}

- (void)postOrder:(OrderObj *)order {
    [NotificationHelper postNotificationWithName:READY_TO_CONFIRM_ORDER andObject:order];
}

- (MapNode *)findMapDataByNodeId:(NSNumber *)nodeId in:(MapData *)mapData {

    if ([mapData isKindOfClass:[MapData class]] && [mapData.nodes isKindOfClass:[NSMutableArray class]]) {
        for (MapNode *node in mapData.nodes) {
            if ([nodeId isEqualToNumber:node.nodeId]) {
                return node;
            }
        }
    } else {
        NSLog(@"map data in not NSArray!!!");
        return nil;
    }
    return nil;
}


@end
