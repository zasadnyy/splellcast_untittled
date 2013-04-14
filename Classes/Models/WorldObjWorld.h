//
//  WorldObjWorld.h
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorldObjWorld : NSObject {
    NSNumber *currentTurnId;
    NSArray *nodes;
}

@property (nonatomic, copy) NSNumber *currentTurnId;
@property (nonatomic, copy) NSArray *nodes;

+ (WorldObjWorld *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
