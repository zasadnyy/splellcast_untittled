//
//  WorldObjPlayersBunnies.h
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorldObjPlayersBunnies : NSObject {
    NSString *name;
    NSString *sessionUid;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sessionUid;

+ (WorldObjPlayersBunnies *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
