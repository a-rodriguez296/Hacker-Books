//
//  ARFLIbraryViewController+CellDelegate.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/26/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLIbraryViewController+CellDelegate.h"

@implementation ARFLIbraryViewController (CellDelegate)

-(void)didSelectView:(id)sender{
    
    //Cambiar el estado del boton
    
    UIButton *btnFavorite = (UIButton *) sender;
    [btnFavorite setSelected:!btnFavorite.isSelected];
    
 
    NSIndexPath *indexPath = [self indexPathWithSender:sender];
    if (indexPath.section == kFavoritesSection) {
        
        
        ARFBook * book = [[ARFLibrary sharedLibrary] getFavoriteBooks][indexPath.row];
        [[ARFLibrary sharedLibrary] markBookFromFavoriteList:book withNotificationOptions:ARFDoesntNeedToBeNotified];
        [self.tableView reloadData];
        
    }
    else{
        NSString *currentTag = [[ARFLibrary sharedLibrary] tagForIndex:indexPath.section-1];
        ARFBook * book = [[ARFLibrary sharedLibrary] bookForTag:currentTag atIndex:indexPath.row];

        [[ARFLibrary sharedLibrary] markBookFromAlphList:book withNotificationOptions:ARFDoesntNeedToBeNotified];
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        [indexSet addIndex:0];
        [indexSet addIndex:indexPath.section];

        [self.tableView reloadData];
    }
    
}

@end
