//
//  ARFLibrary.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARFBook.h"

@interface ARFLibrary : NSObject


+(id)sharedLibrary;

-(void) donwloadBooksWithSuccess:(void (^)(NSArray * books))successBlock
                         failure:(void (^)(NSString *error))failureBlock;

-(NSArray *) libraryBooks;
-(NSUInteger) bookCount;
-(NSArray *) tags;
-(NSUInteger) bookCountForTag:(NSString *) tag;
-(NSArray *) booksForTag:(NSString *) tag;
-(ARFBook *) bookForTag:(NSString *) tag atIndex:(NSUInteger) index;
-(NSString *) tagForIndex:(NSUInteger) index;
-(NSArray *) searchBooksWithTitle:(NSString *)title;
-(NSArray *) sortedBooksWithTitle;
-(NSArray *) favoriteBooks;
//-(void) markBookFromFavoriteList:(ARFBook *) book;
-(void) markBookFromAlphList:(ARFBook *) book;

@end
