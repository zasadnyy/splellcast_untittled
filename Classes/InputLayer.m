//
//  InputLayer.m
//  ScrollingWithJoy
//


#import "InputLayer.h"

@interface InputLayer (PrivateMethods)
-(void) addButtons;
@end

@implementation InputLayer

-(id) init
{
	if ((self = [super init]))
	{
		[self addButtons];

		[self scheduleUpdate];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                         priority:-1
                                                  swallowsTouches:YES];
	}
	return self;
}

- (void) doSomethingOne: (CCMenuItem  *) menuItem
{
	NSLog(@"The first menu was called");
}
- (void) doSomethingTwo: (CCMenuItem  *) menuItem
{
	NSLog(@"The second menu was called");
}
- (void) doSomethingThree: (CCMenuItem  *) menuItem
{
	NSLog(@"The third menu was called");
}
- (void) doSomethingFour: (CCMenuItem  *) menuItem
{
	NSLog(@"The four menu was called");
}
- (void) doSomethingFive: (CCMenuItem  *) menuItem
{
	NSLog(@"The five menu was called");
}

-(void) addButtons
{
    CCMenuItemImage *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"myfirstbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingOne:)];
    CCMenuItemImage *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"mysecondbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingTwo:)];
    CCMenuItemImage *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"mythirdbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingThree:)];
    CCMenuItemImage *menuItem4 = [CCMenuItemImage itemFromNormalImage:@"mythirdbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingFour:)];
    CCMenuItemImage *menuItem5 = [CCMenuItemImage itemFromNormalImage:@"mythirdbutton.png" selectedImage:@"button_selected.png" target:self selector:@selector(doSomethingFive:)];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
	// Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, nil];
    myMenu.scale = 0.5f;
    myMenu.anchorPoint = CGPointZero;
    myMenu.position = ccp(winSize.width * 0.5f, 64.0f);
    
	// Arrange the menu items vertically
	[myMenu alignItemsHorizontally];
    
	// add the menu to your scene
	[self addChild:myMenu];
}


-(void) update:(ccTime)delta
{

}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    
}

@end
