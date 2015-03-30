//
//  ARFBook+Parse.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBook.h"
@class ARFBooksApiClient;
@class  AFHTTPRequestOperationManager;



@interface ARFBook (Parse)

-(void) parseBookWithData:(NSDictionary *) bookDictionary;

@end
