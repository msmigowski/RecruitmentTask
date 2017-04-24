//
//  OriginalDimenstions.m
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 10.09.2016.
//
//

#import "OriginalDimensions.h"

@implementation OriginalDimensions

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if ( [dict isKindOfClass: [NSNull class]] ) {
            self.width = @"0";
            self.height = @"0";
        } else {
            self.width = [dict objectForKey:@"width"];
            self.height = [dict objectForKey:@"height"];
        }
    }
    return self;
}

@end
