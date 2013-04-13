//
// Created by vitaliyzasadnyy on 13.04.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CommandProcessor.h"
#import "BaseCommand.h"
#import "CommandData.h"
#import "HandshakeCommand.h"
#import "GameStartCommand.h"


NSMutableArray *registerCommands();

CommandData *parseMessage(NSString *data);

@implementation CommandProcessor {
    NSMutableArray *_commands;
}

- (id)init {
    self = [super init];
    if (self) {
        _commands = registerCommands();
    }
    return self;
}

- (void)processMessage:(id)data {

    CommandData *commandData = parseMessage(data);

    for (BaseCommand *command in _commands) {
        if ([command.commandId isEqualToString:commandData.commandId]) {
            [command process:commandData];
            return;
        }
    }

    NSLog([NSString stringWithFormat:@"Message %@ is not processed", data]);
}


- (void)dealloc {
    [_commands release];
    [super dealloc];
}


@end

CommandData *parseMessage(NSString *data) {

    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];

    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];

    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {

        NSArray *array = (NSArray *) [jsonArray objectAtIndex:0];
        NSString *commandId = [array objectAtIndex:0];

        NSDictionary *dictionary = [array objectAtIndex:1];
        NSDictionary *messageData = [dictionary valueForKey:@"data"];

        return [[[CommandData alloc] initWithId:commandId andData:messageData] autorelease];
    }
}

NSMutableArray *registerCommands() {
    NSMutableArray *commands = [[NSMutableArray alloc] init];

    [commands addObject:[[HandshakeCommand alloc] init]];
    [commands addObject:[[GameStartCommand alloc] init]];

    return commands;
}