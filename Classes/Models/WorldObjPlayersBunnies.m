//
//  WorldObjPlayersBunnies.m
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import "WorldObjPlayersBunnies.h"

@implementation WorldObjPlayersBunnies

@synthesize name;
@synthesize sessionUid;

- (void)dealloc {

    [name release], name = nil;
    [sessionUid release], sessionUid = nil;

    [super dealloc];

}

+ (WorldObjPlayersBunnies *)instanceFromDictionary:(NSDictionary *)aDictionary {

    WorldObjPlayersBunnies *instance = [[[WorldObjPlayersBunnies alloc] init] autorelease];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"session_uid"]) {
        [self setValue:value forKey:@"sessionUid"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


@end
