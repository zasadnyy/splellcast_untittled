//
//  HelloWorldLayer.h
//  DragDrop
//


#import "cocos2d.h"

@class MapData;

@interface HelloWorld : CCLayer {
    CCSprite *background;
    CCSprite *selSprite;
    NSMutableArray *locations;
}

@property(strong, nonatomic) MapData *mapData;

@property(strong, nonatomic) NSDictionary *ownerMapping;
@property(strong, nonatomic) NSDictionary *nodeTypeSpriteMappingOwl;
@property(strong, nonatomic) NSDictionary *nodeTypeSpriteMappingBunnies;
@property(strong, nonatomic) NSDictionary *nodeTypeSpriteMappingNone;

+ (id)scene;

- (void)makepinch:(UIPinchGestureRecognizer *)pinch;

@end
