//
//  NodeArmy.h
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NodeArmyCrew;

@interface NodeArmy : NSObject {
    NSString *createdAt;
    NodeArmyCrew *crew;
    NSNumber *nodeArmyId;
    NSString *owner;
    NSString *updatedAt;
}

@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, retain) NodeArmyCrew *crew;
@property (nonatomic, copy) NSNumber *nodeArmyId;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *updatedAt;

+ (NodeArmy *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
