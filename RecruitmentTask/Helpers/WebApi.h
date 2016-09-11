//
//  WebApi.h
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 10.09.2016.
//
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(NSData*, NSURLResponse*, NSError*);

@interface WebApi : NSObject

+ (instancetype) sharedApi;
- (void) performRequestGET:(NSString *) stringUrl withParameters:(NSDictionary *)parameters andCompletionBlock: (CompletionBlock)completionBlock;

@end
