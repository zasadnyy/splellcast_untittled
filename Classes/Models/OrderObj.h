//
//  OrderObj.h
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderObj : NSObject {
    NSNumber *locationId;
    NSString *name;
    NSNumber *targetLocationId;
}

@property(nonatomic, copy) NSNumber *locationId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSNumber *targetLocationId;

+ (OrderObj *)instanceFromDictionary:(NSDictionary *)aDictionary;

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
