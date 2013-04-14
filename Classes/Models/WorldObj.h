//
//  WorldObj.h
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorldObjPlayers;
@class WorldObjWorld;

@interface WorldObj : NSObject {
    WorldObjPlayers *players;
    WorldObjWorld *world;
}

@property (nonatomic, retain) WorldObjPlayers *players;
@property (nonatomic, retain) WorldObjWorld *world;

+ (WorldObj *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
