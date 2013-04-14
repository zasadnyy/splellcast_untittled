//
//  InputLayer.m
//  ScrollingWithJoy
//


#import "InputLayer.h"
#import "MapData.h"
#import "MapNode.h"
#import "SimpleAudioEngine.h"

void drawMapNode(id o);

//double findDistance(CGPoint point1, CGPoint point2);

@interface InputLayer (PrivateMethods)
- (void)addButtons;
@end



@implementation InputLayer   {
//    CCSprite *_highlightCastle;
}

- (NSMutableDictionary *)locations {
    if (!_locations) {
        _locations = [[NSMutableDictionary alloc] init];
    }
    return _locations;
}

- (id)init {
    if ((self = [super init])) {
        self.mapData = [[MapData alloc] init];

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


- (void)setInitialPositions {
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

- (void)onCommit:(CCMenuItem *)menuItem {
    NSLog(@"The first menu was called");
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}

- (void)onAttack:(CCMenuItem *)menuItem {
    NSLog(@"The third menu was called");
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}

- (void)onDefence:(CCMenuItem *)menuItem {
    NSLog(@"The four menu was called");
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}

- (void)onSupport:(CCMenuItem *)menuItem {
    NSLog(@"The five menu was called");
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}

- (void)onBuild:(CCMenuItem *)menuItem {
    NSLog(@"The five menu was called");
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
}

- (void)addButtons {
    CGSize winSize = [CCDirector sharedDirector].winSize;

    CCMenuItemImage *defence = [CCMenuItemImage itemFromNormalImage:@"order_defence.png" selectedImage:@"order_defence.png" target:self selector:@selector(onDefence:)];
    CCMenuItemImage *support = [CCMenuItemImage itemFromNormalImage:@"order_support.png" selectedImage:@"order_support.png" target:self selector:@selector(onSupport:)];
    CCMenuItemImage *attack = [CCMenuItemImage itemFromNormalImage:@"order_attack.png" selectedImage:@"order_attack.png" target:self selector:@selector(onAttack:)];
    CCMenuItemImage *build = [CCMenuItemImage itemFromNormalImage:@"order_build.png" selectedImage:@"order_build.png" target:self selector:@selector(onBuild:)];
    CCMenuItemImage *commit = [CCMenuItemImage itemFromNormalImage:@"order_rade.png" selectedImage:@"order_rade.png" target:self selector:@selector(onCommit:)];

    CCMenu *myMenu = [CCMenu menuWithItems:commit, attack, defence, support, build, nil];
    [myMenu alignItemsHorizontally];
    myMenu.anchorPoint = CGPointZero;
    myMenu.position = ccp(winSize.width * 0.5, 38.0f);
    myMenu.scale = 0.5f;

    [self addChild:myMenu];
}


- (void)update:(ccTime)delta {

}


- (void)selectSpriteForTouch:(CGPoint)touchLocation {
//    double MIN_DISTANCE = 100;
//
//    MapNode *selectedNode = nil;
//
//    for (MapNode *node in self.mapData.nodes) {
//        double distance = findDistance(touchLocation, node.coordinate);
//        if (distance < MIN_DISTANCE) {
//            selectedNode = node;
//            break;
//        }
//    }
//
//    if (selectedNode == nil) {
//        NSLog(@"TOUCH TO FAR FROM CASTLES");
//        _highlightCastle.visible = NO;
//        return;
//    }
//
//    _highlightCastle.position = [self convertToNodeSpace:selectedNode.coordinate];
//    _highlightCastle.visible = YES;


//    CCSprite *newSprite = nil;
//    NSArray *sprites = [self.locations allKeys];
//    for (NSString *name in sprites) {
//        CCSprite *sprite = [self.locations valueForKey:name];
//        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
//            newSprite = sprite;
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
    return NO;
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

@end
