//
//  Node.m
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import "Node.h"

#import "NodeArmy.h"

@implementation Node

@synthesize army;
@synthesize nodeId;
@synthesize owner;

- (void)dealloc {

    [army release], army = nil;
    [nodeId release], nodeId = nil;
    [owner release], owner = nil;

    [super dealloc];

}

+ (Node *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Node *instance = [[[Node alloc] init] autorelease];
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

    if ([key isEqualToString:@"army"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.army = [NodeArmy instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"nodeId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


@end
