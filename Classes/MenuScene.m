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

CCSprite *seeker1;
CCSprite *cocosGuy;

// HelloWorld implementation
@implementation MenuScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	MenuScene *layer = [MenuScene node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(void) runGame {
    CCScene *game = [HelloWorld scene];
    [[CCDirector sharedDirector] replaceScene: game];
}

- (void) doSomethingOne: (CCMenuItem  *) menuItem
{
	NSLog(@"The first menu was called");
    [self runGame];
    
}
- (void) doSomethingTwo: (CCMenuItem  *) menuItem
{
	NSLog(@"The second menu was called");
     [self runGame];
}
- (void) doSomethingThree: (CCMenuItem  *) menuItem
{
	NSLog(@"The third menu was called");
     [self runGame];
}


// set up the Menus
-(void) setUpMenus
{
    
	// Create some menu items
    CCMenuItemImage *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"myfirstbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingOne:)];
    CCMenuItemImage *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"mysecondbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingTwo:)];
    CCMenuItemImage *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"mythirdbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingThree:)];
    
    
	// Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    
	// Arrange the menu items vertically
	[myMenu alignItemsVertically];
    
	// add the menu to your scene
	[self addChild:myMenu];
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"m31.jpg"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background];
        
        // schedule a repeating callback on every frame
//      [self schedule:@selector(nextFrame:)];
        [self setUpMenus];
        
		// register to receive targeted touch events
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                         priority:0
                                                  swallowsTouches:YES];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	// don't forget to call "super dealloc"
	[super dealloc];
}
- (void) nextFrame:(ccTime)dt {
   
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	return YES;
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    
}
@end
