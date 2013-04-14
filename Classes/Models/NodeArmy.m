//
//  NodeArmy.m
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import "NodeArmy.h"

#import "NodeArmyCrew.h"

@implementation NodeArmy

@synthesize createdAt;
@synthesize crew;
@synthesize nodeArmyId;
@synthesize owner;
@synthesize updatedAt;

- (void)dealloc {

    [createdAt release], createdAt = nil;
    [crew release], crew = nil;
    [nodeArmyId release], nodeArmyId = nil;
    [owner release], owner = nil;
    [updatedAt release], updatedAt = nil;

    [super dealloc];

}

+ (NodeArmy *)instanceFromDictionary:(NSDictionary *)aDictionary {

    NodeArmy *instance = [[[NodeArmy alloc] init] autorelease];
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

    if ([key isEqualToString:@"crew"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.crew = [NodeArmyCrew instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"nodeArmyId"];
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:value forKey:@"updatedAt"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


@end
