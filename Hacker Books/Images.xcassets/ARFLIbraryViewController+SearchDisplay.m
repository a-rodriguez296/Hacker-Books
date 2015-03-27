//
//  ARFLIbraryViewController+SearchDisplay.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/26/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLIbraryViewController+SearchDisplay.h"

@implementation ARFLIbraryViewController (SearchDisplay)

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [[ARFLibrary sharedLibrary] searchBooksWithTitle:searchString];
    return YES;
}

@end
