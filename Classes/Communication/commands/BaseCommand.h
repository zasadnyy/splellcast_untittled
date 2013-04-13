//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class CommandData;


@interface BaseCommand : NSObject

@property(strong, nonatomic) NSString *commandId;

- (id)initWithName:(NSString *)commandId;

- (BOOL)process:(CommandData *)data;

@end