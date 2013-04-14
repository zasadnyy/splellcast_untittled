//
//  NodeArmyCrew.m
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import "NodeArmyCrew.h"

@implementation NodeArmyCrew

@synthesize footman;
@synthesize knight;

- (void)dealloc {

    [footman release], footman = nil;
    [knight release], knight = nil;

    [super dealloc];

}

+ (NodeArmyCrew *)instanceFromDictionary:(NSDictionary *)aDictionary {

    NodeArmyCrew *instance = [[[NodeArmyCrew alloc] init] autorelease];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

@end
