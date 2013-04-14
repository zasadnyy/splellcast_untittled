//
//  NodeArmyCrew.h
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodeArmyCrew : NSObject {
    NSNumber *footman;
    NSNumber *knight;
}

@property (nonatomic, copy) NSNumber *footman;
@property (nonatomic, copy) NSNumber *knight;

+ (NodeArmyCrew *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
