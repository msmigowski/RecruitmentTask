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
        self.width = [dict objectForKey:@"width"];
        self.height = [dict objectForKey:@"height"];
    }
    return self;
}

@end
