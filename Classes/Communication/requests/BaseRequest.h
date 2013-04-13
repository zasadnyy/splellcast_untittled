//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface BaseRequest : NSObject

@property (strong, nonatomic) NSString * requestName;

-(id)initWithName:(NSString *)name;

-(NSString *) build;

@end