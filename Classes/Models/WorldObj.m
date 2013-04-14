//
//  WorldObj.m
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import "WorldObj.h"

#import "WorldObjPlayers.h"
#import "WorldObjWorld.h"

@implementation WorldObj

@synthesize players;
@synthesize world;

- (void)dealloc {

    [players release], players = nil;
    [world release], world = nil;

    [super dealloc];

}

+ (WorldObj *)instanceFromDictionary:(NSDictionary *)aDictionary {

    WorldObj *instance = [[[WorldObj alloc] init] autorelease];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([key isEqualToString:@"players"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.players = [WorldObjPlayers instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"world"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.world = [WorldObjWorld instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}


@end
