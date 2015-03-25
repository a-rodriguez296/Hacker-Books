//
//  ARFBooksApiClient.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBooksApiClient.h"
#import "AFHTTPRequestOperationManager.h"

@implementation ARFBooksApiClient

+(void) requestBooksWithURL:(NSString *) stURL
                withSuccess:(void (^) (NSArray * books)) successBlock
                withFailure:(void (^)(NSString * error)) failureBlock{
    
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:stURL]];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *responseArray = [NSArray new];
        successBlock(responseArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock([NSString stringWithFormat:@"%@",error]);
    }];
    [requestOperation start];
}

@end
