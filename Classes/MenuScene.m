//
//  MenuScene.m
//  DragDrop
//
//  Created by Vlad Brit on Sat, Apr 13, 13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
#import "HelloWorldScene.h"
#import "DragDropAppDelegate.h"
#include "SimpleAudioEngine.h" 

CCSprite *seeker1;
CCSprite *cocosGuy;

@implementation MenuScene

+ (id)scene {
    CCScene *scene = [CCScene node];

    MenuScene *layer = [MenuScene node];

    [scene addChild:layer];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"menu.mp3"];

    return scene;
}

- (void)runGame {
    CCScene *game = [HelloWorld scene];
    [[CCDirector sharedDirector] replaceScene:game];
}

- (void)doSomethingOne:(CCMenuItem *)menuItem {
    NSLog(@"The first menu was called");
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
    [self runGame];
}

//- (void)doSomethingTwo:(CCMenuItem *)menuItem {
//    NSLog(@"The second menu was called");
//    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
//    [self runGame];
//}
//
//- (void)doSomethingThree:(CCMenuItem *)menuItem {
//    NSLog(@"The third menu was called");
//    [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
//    [self runGame];
//}


- (void)setUpMenus {

    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCMenuItemImage *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"myfirstbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingOne:)];
//    CCMenuItemImage *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"mysecondbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingTwo:)];
//    CCMenuItemImage *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"mythirdbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingThree:)];


    CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, nil];

    [myMenu alignItemsVertically];
     myMenu.position = ccp(winSize.width * 0.5, winSize.height * 0.5);
//    [menuItem1 setBlendFunc: (ccBlendFunc) { GL_SRC_ALPHA, GL_ONE }];


    [self addChild:myMenu];
}

- (id)init {
    if ((self = [super init])) {

        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"m31.jpg"];
        background.anchorPoint = ccp(0, 0);
        [self addChild:background];

//      [self schedule:@selector(nextFrame:)];
        [self setUpMenus];

        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                         priority:0
                                                  swallowsTouches:YES];
    }
    return self;
}


- (void)dealloc {
    [super dealloc];
}

- (void)nextFrame:(ccTime)dt {

}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];

}
@end
