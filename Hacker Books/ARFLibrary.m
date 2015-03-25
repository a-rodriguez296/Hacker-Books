//
//  ARFLibrary.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLibrary.h"
#import "ARFBooksApiClient.h"
#import "ARFConstants.h"


@interface ARFLibrary()

@property(nonatomic, strong) NSArray * books;

@end

@implementation ARFLibrary


#pragma mark Public Methods
+(id)sharedLibrary{
    static ARFLibrary *sharedLibrary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLibrary = [[self alloc] init];
    });
    return sharedLibrary;
}

-(void) donwloadBooksWithSuccess:(void (^)(NSArray * books))successBlock
                         failure:(void (^)(NSString *apiError))failureBlock{
    
    //Acá se debe llamar un método que se encarga de la descarga de los libros y devuelve un bloque. En caso exitoso se retorna YES, de lo contrario NO;
    
    [ARFBooksApiClient requestBooksWithURL:kBooksUrl withSuccess:^(NSArray *books) {
        successBlock(books);
        self.books = books;
    } withFailure:^(NSString *error) {
        failureBlock(error);
    }];
}


-(NSArray *) libraryBooks{
    return self.books;
}


-(NSUInteger) bookCount{
    return self.books.count;
}


-(NSArray *) tags{
    
    NSMutableArray *responseArray = [NSMutableArray new];
    for (ARFBook *book in self.books) {
        [self addArrayToArrayWithoutRepetition:book.tagsList anotherArray:responseArray];
    }
    return [NSArray arrayWithArray:responseArray];
}


-(NSUInteger) bookCountForTag:(NSString *) tag{
    
    NSUInteger response = 0;
    for (ARFBook *book in self.books) {
        if ([book.tagsList containsObject:tag]) {
            response++;
        }
    }
    return response;
}

-(NSArray *) booksForTag:(NSString *) tag{
    
    NSMutableArray *responseArray = [NSMutableArray new];
    for (ARFBook *book in self.books) {
        if ([book.tagsList containsObject:tag]) {
            [responseArray addObject:book];
        }
    }
    return responseArray.count>0?[NSArray arrayWithArray:responseArray]:nil;
}

-(ARFBook *) bookForTag:(NSString *) tag atIndex:(NSUInteger) index{
    
    NSArray *booksForTag = [self booksForTag:tag];
    if (index>booksForTag.count) {
        return nil;
    }
    else{
        return booksForTag[index];
    }
}


#pragma mark Aux Methods
-(void) addArrayToArrayWithoutRepetition:(NSArray *) array anotherArray:(NSMutableArray *) anArray{
    for (id currentElement in array) {
        if (![anArray containsObject:currentElement]) {
            [anArray addObject:currentElement];
        }
    }
}

@end
