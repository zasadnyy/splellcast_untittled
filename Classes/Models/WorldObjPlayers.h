//
//  WorldObjPlayers.h
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorldObjPlayersBunnies;
@class WorldObjPlayersOwls;

@interface WorldObjPlayers : NSObject {
    WorldObjPlayersBunnies *bunnies;
    WorldObjPlayersOwls *owls;
}

@property (nonatomic, retain) WorldObjPlayersBunnies *bunnies;
@property (nonatomic, retain) WorldObjPlayersOwls *owls;

+ (WorldObjPlayers *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
