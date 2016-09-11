//
//  Revision.m
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 10.09.2016.
//
//

#import "Revision.h"

@implementation Revision

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.idRevision = [dict objectForKey:@"id"];
        self.user = [dict objectForKey:@"user"];
        self.user_id = [dict objectForKey:@"user_id"];
        self.timestamp = [dict objectForKey:@"timestamp"];
    }
    return self;
}

@end
