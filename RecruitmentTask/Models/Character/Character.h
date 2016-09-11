//
//  Character.h
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 09.09.2016.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Revision.h"
#import "OriginalDimensions.h"


@interface Character : NSObject

// TODO: Temporary only NSString's
@property NSString *idNumber;
@property NSString *title;
@property NSString *ns;
@property Revision *revision;
@property NSString *comments;
@property NSString *type;
@property NSString *abstract;
@property NSString *thumbnail;
@property NSString *url;
@property OriginalDimensions *dimensions;
@property UIImage *thumbnailImage;
@property BOOL favourite;

- (instancetype)initWithDictionary: (NSDictionary *) dict;

@end
