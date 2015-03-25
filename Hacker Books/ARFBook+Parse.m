//
//  ARFBook+Parse.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBook+Parse.h"

@implementation ARFBook (Parse)

-(void) parseBookWithData:(NSDictionary *) bookDictionary{
    
    [self setTitle:[bookDictionary objectForKey:@"title"]];
    [self setAuthorsList:[[bookDictionary objectForKey:@"authors"] componentsSeparatedByString:@","]];
    [self setTagsList:[[bookDictionary objectForKey:@"tags"] componentsSeparatedByString:@","]];
    [self setUrlImage:[bookDictionary objectForKey:@"image_url"]];
    [self setUrlPDF:[bookDictionary objectForKey:@"pdf_url"]];
    [self setIsFavorite:NO];
}


@end
