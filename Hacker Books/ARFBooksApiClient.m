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
        NSLog(@"%@", NSStringFromClass([responseObject class]));
        NSError *errorJson;
        
//        [self saveJSONInSandboxWithData:responseObject];
        
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




//+(void) saveJSONInSandboxWithData:(NSData *) data{
//    
//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSURL *baseUrl = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//    
//    NSURL *jsonURL = [NSURL URLWithString:@"json.txt" relativeToURL:baseUrl];
//    NSString *stJsonURL = [jsonURL absoluteString];
//    if (![fm fileExistsAtPath:stJsonURL]) {
//        BOOL a = [fm createFileAtPath:stJsonURL contents:data attributes:nil];
//        NSLog(@"%i",a);
//    }
//   
//    
//    NSError *error;
////    BOOL didSave = [data writeToFile:  options:NSDataWritingAtomic error:&error];
//    
//    
//}

@end
