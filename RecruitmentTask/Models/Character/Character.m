//
//  Character.m
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 09.09.2016.
//
//

#import "Character.h"


@implementation Character

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
//        @try {
            self.favourite = NO;
            self.idNumber = [dict objectForKey:@"id"];
            self.title = [dict objectForKey:@"title"];
            self.ns = [dict objectForKey:@"ns"];
            self.revision = [[Revision alloc] initWithDictionary:[dict objectForKey:@"revision"]];
            self.comments = [dict objectForKey:@"comments"];
            self.type = [dict objectForKey:@"type"];
            self.abstract = [dict objectForKey:@"abstract"];
            self.thumbnail = [dict objectForKey:@"thumbnail"];
            self.url = [dict objectForKey:@"url"];
            self.dimensions = [[OriginalDimensions alloc] initWithDictionary: [dict objectForKey:@"original_dimensions"]];
//        } @catch (NSException *exception) {
            
            
//            NSLog(@"%@", exception.description);
//        }

    }
    return self;
}

@end
