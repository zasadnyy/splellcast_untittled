//
// Created by vitaliyzasadnyy on 14.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaseCommand.h"
#import "GameStartCommand.h"
#import "CommandData.h"
#import "World.h"
#import "NotificationHelper.h"


@implementation GameStartCommand {

}
- (id)init {
    return [super initWithName:@"game_start"];
}

- (BOOL)process:(CommandData *)data {

    World *world = [self parseWorld:data.messageData];
    [NotificationHelper postNotificationWithName:WORLD_OBJECT_ARRIVED andObject:world];

    return YES;
}

- (World *)parseWorld:(NSDictionary *)messageData {
    return [[World alloc] init];
}


@end