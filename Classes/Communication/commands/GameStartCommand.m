//
// Created by vitaliyzasadnyy on 14.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaseCommand.h"
#import "GameStartCommand.h"
#import "CommandData.h"
#import "NotificationHelper.h"
#import "WorldObj.h"


@implementation GameStartCommand {

}
- (id)init {
    return [super initWithName:@"game_start"];
}

- (BOOL)process:(CommandData *)data {

    WorldObj *world = [self parseWorld:data.messageData];
    [NotificationHelper postNotificationWithName:WORLD_OBJECT_ARRIVED andObject:world];

    return YES;
}

- (WorldObj *)parseWorld:(NSDictionary *)messageData {
    WorldObj *worldObj = [WorldObj instanceFromDictionary:messageData];
    return worldObj;
}


@end