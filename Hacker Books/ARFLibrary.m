//
//  ARFLibrary.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLibrary.h"
#import "ARFBooksApiClient.h"
#import "ARFSerializerUtils.h"
#import "ARFBook.h"

@interface ARFLibrary()

//Entire Book list
@property(nonatomic, strong) NSMutableArray * tagListbooks;


//Sorted list by title
@property (nonatomic, strong) NSArray *sortedBooks;


@property (nonatomic, strong) NSMutableArray *favoriteBooks;


@property (nonatomic, strong) NSArray *completeBookArray;
@property (nonatomic, strong) NSMutableArray *tagList;

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


-(void) decodeBooks{
        [self initializeLibraryWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[ARFSerializerUtils pathForBooks]]];
    
}

-(void) donwloadBooksWithSuccess:(void (^)(BOOL success))successBlock{
    
    
    [ARFBooksApiClient requestBooksWithURL:kBooksUrl withSuccess:^(BOOL success) {
        [self initializeLibraryWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[ARFSerializerUtils pathForBooks]]];
        successBlock(success);
    }];

}

-(void) initializeTags{
    NSMutableArray *responseArray = [NSMutableArray new];
    for (ARFBook *book in self.completeBookArray) {
        if (!book.isFavorite) {
            [self addArrayToArrayWithoutRepetition:book.tagsList anotherArray:responseArray];
        }
    }
    self.tagList = responseArray;
}

-(NSArray *) tags{
    return [self.tagList sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}


-(NSUInteger) bookCountForTag:(NSString *) tag{
    
    NSUInteger response = 0;
    for (ARFBook *book in self.completeBookArray) {
        if ([book.tagsList containsObject:tag] && !book.isFavorite) {
            response++;
        }
    }
    return response;
}

-(NSArray *) booksForTag:(NSString *) tag{
    
    NSMutableArray *responseArray = [NSMutableArray new];
    for (ARFBook *book in self.completeBookArray) {
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


-(NSArray *) sortedBooksWithTitle{
    return self.sortedBooks;
}

-(NSArray *) getFavoriteBooks{
    NSMutableArray * responseArray = [NSMutableArray new];
    for (ARFBook *book in self.completeBookArray) {
        if ([book isFavorite]) {
            [responseArray addObject:book];
        }
    }
    return [NSArray arrayWithArray:responseArray];
}



-(void) markBookFromAlphList:(ARFBook *)book withNotificationOptions:(ARFNotificationOptions) option{
    
    
    //En caso de q alguno de los tags del libro sólo lo contenga a él (que sólo tenga un libro ese tag), se debe eliminar el tag de la lista
    for (NSString *tag in book.tagsList) {
        if ([self bookCountForTag:tag] == 1) {
            [self.tagList removeObject:tag];
        }
    }
    
    [book setIsFavorite:YES];
    if (option == ARFNeedsToBeNotified) {
        [self sendDidMarkBookNotificationWithBook:book];
    }
    //Serialización de la información
    [self serializeData];
}

-(void) markBookFromFavoriteList:(ARFBook *) book  withNotificationOptions:(ARFNotificationOptions) option{
    
    //Se buscan los tags del libro. Si hay alguno tag para el cual no hayan libros, se agrega el tag a la lista
    for (NSString *tag in book.tagsList) {
        if ([self bookCountForTag:tag] == 0 ) {
            [self.tagList addObject:tag];
        }
    }
    [book setIsFavorite:NO];
    if (option == ARFNeedsToBeNotified) {
        [self sendDidMarkBookNotificationWithBook:book];
    }
    //Serialización de la información
    [self serializeData];
}


#pragma mark Aux Methods
-(void) addArrayToArrayWithoutRepetition:(NSArray *) array anotherArray:(NSMutableArray *) anArray{
    for (id currentElement in array) {
        if (![anArray containsObject:currentElement]) {
            [anArray addObject:currentElement];
        }
    }
}

-(void) initializeLibraryWithArray:(NSArray *) array{
    self.completeBookArray = array;
    self.tagListbooks = [NSMutableArray arrayWithArray:array];
    [self initializeTags];
}

-(void) serializeData{
    [ARFBooksApiClient serializeDataWithArray:self.completeBookArray withSuccess:^(BOOL success) {
        
    }];
}

-(ARFBook *) firstBook{
    
    if ([self getFavoriteBooks].count > 0) {
        
        //Caso en el que hay favoritos
        
        return [self getFavoriteBooks][0];
        
    }
    else{
        //Caso en el que no hay favoritos
        NSString *firstTag =[[ARFLibrary sharedLibrary] tags][0];
        return  [[ARFLibrary sharedLibrary] booksForTag:firstTag][0];
    }
}

#pragma mark Notifications
-(void) sendDidMarkBookNotificationWithBook:(ARFBook *) book{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidMarkBookAsFavoriteNotification object:self userInfo:@{@"book":book}];
}



//-(NSArray *) searchBooksWithTitle:(NSString *)title{
//    NSMutableArray *responseArray = [NSMutableArray new];
//    for (ARFBook *book in self.tagListbooks) {
//        if ([book.title containsString:title]) {
//            [responseArray addObject:book];
//        }
//    }
//    self.sortedBooks = [NSArray arrayWithArray:responseArray];
//    return [NSArray arrayWithArray:responseArray];
//}

@end
