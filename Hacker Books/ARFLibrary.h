//
//  ARFLibrary.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARFLibrary : NSObject


+(id)sharedLibrary;

-(void) donwloadBooks;

@end
