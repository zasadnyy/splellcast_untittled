//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface CommandData : NSObject

-(id)initWithId:(NSString *)id andData:(NSDictionary *)data;

@property (strong, nonatomic) NSString * commandId;
@property (strong, nonatomic) NSDictionary *messageData;

@end