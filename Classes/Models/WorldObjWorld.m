//
//  WorldObjWorld.m
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import "WorldObjWorld.h"

#import "Node.h"

@implementation WorldObjWorld

@synthesize currentTurnId;
@synthesize nodes;

- (void)dealloc {

    [currentTurnId release], currentTurnId = nil;
    [nodes release], nodes = nil;

    [super dealloc];

}

+ (WorldObjWorld *)instanceFromDictionary:(NSDictionary *)aDictionary {

    WorldObjWorld *instance = [[[WorldObjWorld alloc] init] autorelease];
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

    if ([key isEqualToString:@"nodes"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                Node *populatedMember = [Node instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.nodes = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"current_turn_id"]) {
        [self setValue:value forKey:@"currentTurnId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


@end
