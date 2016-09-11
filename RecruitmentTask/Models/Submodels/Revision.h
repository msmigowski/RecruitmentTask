//
//  Revision.h
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 10.09.2016.
//
//

#import <Foundation/Foundation.h>

@interface Revision : NSObject

@property NSString *idRevision;
@property NSString *user;
@property NSString *user_id;
@property NSString *timestamp;

- (instancetype)initWithDictionary: (NSDictionary *) dict;

@end
