//
//  ARFConstants.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

static NSString* const kBooksUrl                      = @"https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json";
static NSString *const kDidMarkBookAsFavoriteNotification = @"didMarkBook";
static NSString *const kDataFileName = @"data.txt";


#define _ME_WEAK __weak typeof(self) me = self;


typedef enum{
    ARFNeedsToBeNotified,
    ARFDoesntNeedToBeNotified

} ARFNotificationOptions;


