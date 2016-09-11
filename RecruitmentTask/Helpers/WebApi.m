//
//  WebApi.m
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 10.09.2016.
//
//

#import "WebApi.h"

@implementation WebApi

+ (instancetype) sharedApi {
    static WebApi *myApi = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        myApi = [[WebApi alloc] init];
    });
    
    return myApi;
}

// pragma mark - GET request
- (void) performRequestGET: (NSString *) stringUrl
            withParameters: (NSDictionary *)parameters
        andCompletionBlock: (CompletionBlock)completionBlock {
    
    // Prepare string
    NSString *mutableString = [[NSString alloc] initWithString: stringUrl];
    
    for (NSString *key in parameters) {
        NSString* stringParameters = [NSString stringWithFormat:@"%@=%@", key, [parameters valueForKey:key]];
        mutableString = [mutableString stringByAppendingFormat:@"%@&", stringParameters];
    }
    mutableString = [mutableString substringToIndex:mutableString.length-(mutableString.length>0)];
    NSLog(@"%@", mutableString);
    
    // Get url from prepared strirng
    NSURL *urlRequest = [[NSURL alloc] initWithString:mutableString];
    if (urlRequest == nil) {
        // TODO: Alert url isnt created, show alert
        return;
    }
    
    // Configure request
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:urlRequest];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
    
    // Send request
    [[[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler: completionBlock] resume];
}

@end
