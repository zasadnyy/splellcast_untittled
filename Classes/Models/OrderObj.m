//
//  OrderObj.m
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import "OrderObj.h"

@implementation OrderObj

@synthesize locationId;
@synthesize name;
@synthesize targetLocationId;

- (void)dealloc {

    [locationId release], locationId = nil;
    [name release], name = nil;
    [targetLocationId release], targetLocationId = nil;

    [super dealloc];

}

+ (OrderObj *)instanceFromDictionary:(NSDictionary *)aDictionary {

    OrderObj *instance = [[[OrderObj alloc] init] autorelease];
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

    if ([key isEqualToString:@"location_id"]) {
        [self setValue:value forKey:@"locationId"];
    } else if ([key isEqualToString:@"target_location_id"]) {
        [self setValue:value forKey:@"targetLocationId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


@end
