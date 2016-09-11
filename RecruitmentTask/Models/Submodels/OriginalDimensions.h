//
//  OriginalDimenstions.h
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 10.09.2016.
//
//

#import <Foundation/Foundation.h>

@interface OriginalDimensions : NSObject

@property NSString *width;
@property NSString *height;

- (instancetype)initWithDictionary: (NSDictionary *) dict;

@end
