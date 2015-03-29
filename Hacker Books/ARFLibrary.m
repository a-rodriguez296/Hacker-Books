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

//Entire Book list
@property(nonatomic, strong) NSMutableArray * tagListbooks;


//Sorted list by title
@property (nonatomic, strong) NSArray *sortedBooks;


@property (nonatomic, strong) NSMutableArray *favoriteBooksa;

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
        self.tagListbooks = [NSMutableArray arrayWithArray:books];
        successBlock(books);
    } withFailure:^(NSString *error) {
        failureBlock(error);
    }];
}


-(NSArray *) libraryBooks{
    return self.tagListbooks;
}


-(NSUInteger) bookCount{
    return self.tagListbooks.count;
}


-(NSArray *) tags{
    
    NSMutableArray *responseArray = [NSMutableArray new];
    for (ARFBook *book in self.tagListbooks) {
        [self addArrayToArrayWithoutRepetition:book.tagsList anotherArray:responseArray];
    }
    return [NSArray arrayWithArray:[responseArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
}


-(NSUInteger) bookCountForTag:(NSString *) tag{
    
    NSUInteger response = 0;
    for (ARFBook *book in self.tagListbooks) {
        if ([book.tagsList containsObject:tag]) {
            response++;
        }
    }
    return response;
}

-(NSArray *) booksForTag:(NSString *) tag{
    
    NSMutableArray *responseArray = [NSMutableArray new];
    for (ARFBook *book in self.tagListbooks) {
        if ([book.tagsList containsObject:tag] && !book.isFavorite) {
            [responseArray addObject:book];
        }
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    NSArray *sortedResponseArray = [responseArray sortedArrayUsingDescriptors:@[sort]];
    
    return responseArray.count>0?sortedResponseArray:nil;
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

-(NSString *) tagForIndex:(NSUInteger) index{
    return [self tags][index];
}


-(NSArray *) searchBooksWithTitle:(NSString *)title{
    NSMutableArray *responseArray = [NSMutableArray new];
    for (ARFBook *book in self.tagListbooks) {
        if ([book.title containsString:title]) {
            [responseArray addObject:book];
        }
    }
    self.sortedBooks = [NSArray arrayWithArray:responseArray];
    return [NSArray arrayWithArray:responseArray];
}

-(NSArray *) sortedBooksWithTitle{
    return self.sortedBooks;
}

-(NSArray *) favoriteBooks{
    
    if (self.favoriteBooksa == nil) {
        NSMutableArray *responseArray = [NSMutableArray new];
        for (ARFBook *currentBook in self.tagListbooks) {
            if ([currentBook isFavorite]) {
                [responseArray addObject:currentBook];
            }
        }
        self.favoriteBooksa =responseArray;
        return responseArray;
    }
    else{
        return self.favoriteBooksa;
    }
}



-(void) markBookFromAlphList:(ARFBook *) book{
    
    [self.favoriteBooksa addObject:book];
    [self.tagListbooks removeObject:book];
}

-(void) markBookFromFavoriteList:(ARFBook *) book{
    [self.favoriteBooksa removeObject:book];
    [self.tagListbooks addObject:book];
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
