//
//  ARFBooksApiClient.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBooksApiClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "ARFBook+Parse.h"

@implementation ARFBooksApiClient

+(void) requestBooksWithURL:(NSString *) stURL
                withSuccess:(void (^) (NSArray * books)) successBlock
                withFailure:(void (^)(NSString * error)) failureBlock{

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:stURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray * responseArray = [NSMutableArray new];
        
        NSError *errorJson;
        NSArray* objectsArray = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&errorJson];
        
        for (NSDictionary *bookDictionary in objectsArray) {
            ARFBook *book = [ARFBook new];
            [book parseBookWithData:bookDictionary];
            [responseArray addObject:book];
        }
        
        successBlock([NSArray arrayWithArray:responseArray]);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
