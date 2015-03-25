//
//  ARFBook.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARFBook : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSArray * authorsList;
@property (nonatomic, strong) NSArray *tagsList;
@property (nonatomic, strong) NSString *urlImage;
@property (nonatomic, strong) NSString *urlPDF;
@property (nonatomic, assign) BOOL isFavorite;


@end
