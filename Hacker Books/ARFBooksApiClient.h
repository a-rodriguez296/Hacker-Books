//
//  ARFBooksApiClient.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ARFBooksApiClient;
@class AFHTTPRequestOperationManager;
@class ARFBook;
@class ARFConstants;
@class ARFSerializerUtils;


@import UIKit;

@interface ARFBooksApiClient : NSObject

+(void) requestBooksWithURL:(NSString *) stURL
                withSuccess:(void (^) (BOOL success)) successBlock;


+(void) serializeDataWithArray:(NSArray *) booksArray
                   withSuccess:(void (^) (BOOL  success)) successBlock;


+(void) donwloadDataWithURL:(NSString *) url
                    success:(void(^)(BOOL success, NSData *data)) successBlock;

+(void) saveDataOnDiskWithURL:(NSString *) url withData:(NSData *)data
                  withSuccess:(void(^) (BOOL success)) successBlock;
@end
