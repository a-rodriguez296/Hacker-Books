//
//  ARFBook.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  ARFBook;
@class ARFBooksApiClient;


@interface ARFBook : NSObject <NSCoding>

@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSArray * authorsList;
@property (nonatomic, strong) NSArray *tagsList;
@property (nonatomic, copy) NSString *urlImage;
@property (nonatomic, copy) NSString *urlPDF;
@property (nonatomic) BOOL isFavorite;


+(NSData *) getDataWithstURL:(NSString *) stURL;
+(void) donwloadPDFDataWithBook:(ARFBook *) book
                        success:(void (^)(BOOL success, NSString * stRelativeUrl))successBlock;

@end
