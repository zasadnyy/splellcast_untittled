//
//  Node.h
//  
//
//  Created by ___FULLUSERNAME___ on 14.04.13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NodeArmy;

@interface Node : NSObject {
    NodeArmy *army;
    NSNumber *nodeId;
    NSString *owner;
}

@property (nonatomic, retain) NodeArmy *army;
@property (nonatomic, copy) NSNumber *nodeId;
@property (nonatomic, copy) NSString *owner;

+ (Node *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
