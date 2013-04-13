//
//  MenuScene.h
//  DragDrop
//
//  Created by Vlad Brit on Sat, Apr 13, 13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DragDropAppDelegate.h"
#import "cocos2d.h"

@interface MenuScene : CCLayer {
        CCSprite * background;
}
+(id) scene;
-(void) setUpMenus;
@end
