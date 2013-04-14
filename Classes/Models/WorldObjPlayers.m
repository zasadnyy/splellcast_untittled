//
//  WorldObjPlayers.m
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import "WorldObjPlayers.h"

#import "WorldObjPlayersBunnies.h"
#import "WorldObjPlayersOwls.h"

@implementation WorldObjPlayers

@synthesize bunnies;
@synthesize owls;

- (void)dealloc {

    [bunnies release], bunnies = nil;
    [owls release], owls = nil;

    [super dealloc];

}

+ (WorldObjPlayers *)instanceFromDictionary:(NSDictionary *)aDictionary {

    WorldObjPlayers *instance = [[[WorldObjPlayers alloc] init] autorelease];
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

    if ([key isEqualToString:@"bunnies"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.bunnies = [WorldObjPlayersBunnies instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"owls"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.owls = [WorldObjPlayersOwls instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}


@end
