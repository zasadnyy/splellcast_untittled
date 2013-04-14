//
// Created by vitaliyzasadnyy on 14.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MapNode.h"
#import "RandomHelper.h"

NSString *const NODE_TYPE_CAPITAL = @"capital";
NSString *const NODE_TYPE_LARGE_CASTLE = @"large_castle";
NSString *const NODE_TYPE_SMALL_CASTLE = @"small_castle";
NSString *const NODE_TYPE_NO_CASTLE = @"no_castle";

NSString *const NODE_OWNER_OWLS = @"owls";
NSString *const NODE_OWNER_BUNNIES = @"bunnies";
NSString *const NODE_OWNER_NONE = @"owner_none";

@implementation MapNode {

}

@synthesize nodeId, nodeType, neigborhoods, coordinate, owner, footmanNumber, knightNumber;

- (id)initWithNodeId:(NSNumber *)aNodeId nodeType:(NSString *)aNodeType neigborhoods:(NSArray *)aNeigborhoods coordinate:(CGPoint)aCoordinate owner:(NSString *)anOwner {
    self = [super init];
    if (self) {
        coordinate = aCoordinate;
        neigborhoods = [aNeigborhoods retain];
        nodeId = [aNodeId retain];
        nodeType = [aNodeType copy];
        owner = [anOwner copy];
        footmanNumber = [NSNumber numberWithInt:[RandomHelper getRandomNumberBetween:0 to:5]];
        knightNumber = [NSNumber numberWithInt:[RandomHelper getRandomNumberBetween:0 to:5]];;
    }

    return self;
}

- (void)dealloc {
    [neigborhoods release];
    [nodeId release];
    [nodeType release];
    [owner release];
    [super dealloc];
}

+ (id)objectWithNodeId:(NSNumber *)aNodeId nodeType:(NSString *)aNodeType neigborhoods:(NSArray *)aNeigborhoods coordinate:(CGPoint)aCoordinate owner:(NSString *)anOwner {
    return [[[MapNode alloc] initWithNodeId:aNodeId nodeType:aNodeType neigborhoods:aNeigborhoods coordinate:aCoordinate owner:anOwner] autorelease];
}




@end