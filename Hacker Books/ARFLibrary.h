//
//  ARFLibrary.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARFConstants.h"
@class ARFBook;


@interface ARFLibrary : NSObject


+(id)sharedLibrary;
-(void) decodeBooks;
-(void) donwloadBooksWithSuccess:(void (^)(BOOL success)) successBlock;


-(NSArray *) tags;
-(NSUInteger) bookCountForTag:(NSString *) tag;
-(NSArray *) booksForTag:(NSString *) tag;
-(ARFBook *) bookForTag:(NSString *) tag atIndex:(NSUInteger) index;
-(NSString *) tagForIndex:(NSUInteger) index;
-(NSArray *) sortedBooksWithTitle;
-(NSArray *) getFavoriteBooks;
-(void) markBookFromFavoriteList:(ARFBook *) book withNotificationOptions:(ARFNotificationOptions) option;
-(void) markBookFromAlphList:(ARFBook *)book withNotificationOptions:(ARFNotificationOptions) option;



-(ARFBook *) firstBook;
@end
