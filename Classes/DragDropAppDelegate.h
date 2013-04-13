//
//  DragDropAppDelegate.h
//  DragDrop
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface DragDropAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
