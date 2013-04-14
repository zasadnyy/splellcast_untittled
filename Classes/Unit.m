//
//  Unit.m
//  SpriteBatches
//


#import "Unit.h"

@interface Unit (PrivateMethods)
-(id) initWithShipImage;
@end


@implementation Unit

+(id) unit
{
	return [[self alloc] initWithShipImage];
}

-(id) initWithShipImage
{
	if ((self = [super initWithSpriteFrameName:@"Helcopter_P1.png"]))
	{	
		[self scheduleUpdate];
	}
	return self;
}

-(void) update:(ccTime)delta
{


}

-(void) setPosition:(CGPoint)pos
{
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	float halfWidth = contentSize_.width * 0.5f;
	float halfHeight = contentSize_.height * 0.5f;
	
	if (pos.x < halfWidth)
	{
		pos.x = halfWidth;
	}
	else if (pos.x > (screenSize.width - halfWidth))
	{
		pos.x = screenSize.width - halfWidth;
	}
	
	if (pos.y < halfHeight)
	{
		pos.y = halfHeight;
	}
	else if (pos.y > (screenSize.height - halfHeight))
	{
		pos.y = screenSize.height - halfHeight;
	}
	
	[super setPosition:pos];
}

@end
