//
// Created by vitaliyzasadnyy on 14.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MapData.h"
#import "MapNode.h"


@implementation MapData {

}

@synthesize nodes = _nodes;

- (id)init {
    self = [super init];
    if (self) {
        _nodes = [self registerNodes];
    }
    return self;
}

- (NSMutableArray *)registerNodes {
    NSMutableArray *nodes = [[[NSMutableArray alloc] init] autorelease];

    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:1] nodeType:NODE_TYPE_CAPITAL neigborhoods:@[@2, @3] coordinate:CGPointMake(670, 410) owner:NODE_OWNER_OWLS]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:2] nodeType:NODE_TYPE_SMALL_CASTLE neigborhoods:@[@1, @3, @4, @5] coordinate:CGPointMake(1022, 410) owner:NODE_OWNER_OWLS]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:3] nodeType:NODE_TYPE_NO_CASTLE neigborhoods:@[@1, @2, @7] coordinate:CGPointMake(330, 700) owner:NODE_OWNER_OWLS]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:4] nodeType:NODE_TYPE_CAPITAL neigborhoods:@[@2, @5, @8] coordinate:CGPointMake(500, 1096) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:5] nodeType:NODE_TYPE_NO_CASTLE neigborhoods:@[@2, @4, @12, @6, @9] coordinate:CGPointMake(815, 845) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:6] nodeType:NODE_TYPE_SMALL_CASTLE neigborhoods:@[@5, @9, @13, @7] coordinate:CGPointMake(1253, 485) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:7] nodeType:NODE_TYPE_NO_CASTLE neigborhoods:@[@3, @6, @10] coordinate:CGPointMake(1537, 230) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:8] nodeType:NODE_TYPE_LARGE_CASTLE neigborhoods:@[@4, @11] coordinate:CGPointMake(309, 1330) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:9] nodeType:NODE_TYPE_LARGE_CASTLE neigborhoods:@[@5, @6, @12, @13] coordinate:CGPointMake(1160, 930) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:10] nodeType:NODE_TYPE_LARGE_CASTLE neigborhoods:@[@7, @14] coordinate:CGPointMake(1761, 357) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:11] nodeType:NODE_TYPE_NO_CASTLE neigborhoods:@[@8, @12, @15] coordinate:CGPointMake(500, 1460) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:12] nodeType:NODE_TYPE_SMALL_CASTLE neigborhoods:@[@11, @5, @9, @13] coordinate:CGPointMake(1000, 1270) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:13] nodeType:NODE_TYPE_NO_CASTLE neigborhoods:@[@6, @9, @12, @16, @14] coordinate:CGPointMake(1329, 1076) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:14] nodeType:NODE_TYPE_NO_CASTLE neigborhoods:@[@13, @16, @10] coordinate:CGPointMake(1666, 807) owner:NODE_OWNER_NONE]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:15] nodeType:NODE_TYPE_NO_CASTLE neigborhoods:@[@11, @17, @16] coordinate:CGPointMake(811, 1609) owner:NODE_OWNER_BUNNIES]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:16] nodeType:NODE_TYPE_SMALL_CASTLE neigborhoods:@[@13, @14, @15] coordinate:CGPointMake(1603, 1242) owner:NODE_OWNER_BUNNIES]];
    [nodes addObject:[MapNode objectWithNodeId:[NSNumber numberWithInt:17] nodeType:NODE_TYPE_CAPITAL neigborhoods:@[@11, @15, @16] coordinate:CGPointMake(854, 1898) owner:NODE_OWNER_BUNNIES]];

    return nodes;
}


@end