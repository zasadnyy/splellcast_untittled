//
// Created by vitaliyzasadnyy on 14.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

extern NSString *const NODE_TYPE_CAPITAL;
extern NSString *const NODE_TYPE_LARGE_CASTLE;
extern NSString *const NODE_TYPE_SMALL_CASTLE;
extern NSString *const NODE_TYPE_NO_CASTLE;

extern NSString *const NODE_OWNER_OWLS;
extern NSString *const NODE_OWNER_BUNNIES;
extern NSString *const NODE_OWNER_NONE;


@interface MapNode : NSObject

@property(strong, nonatomic) NSNumber *nodeId;
@property(strong, nonatomic) NSString *nodeType;
@property(strong, nonatomic) NSArray *neigborhoods;
@property CGPoint coordinate;
@property(strong, nonatomic) NSString *owner;

- (id)initWithNodeId:(NSNumber *)aNodeId nodeType:(NSString *)aNodeType neigborhoods:(NSArray *)aNeigborhoods coordinate:(CGPoint)aCoordinate owner:(NSString *)anOwner;

+ (id)objectWithNodeId:(NSNumber *)aNodeId nodeType:(NSString *)aNodeType neigborhoods:(NSArray *)aNeigborhoods coordinate:(CGPoint)aCoordinate owner:(NSString *)anOwner;


@end

