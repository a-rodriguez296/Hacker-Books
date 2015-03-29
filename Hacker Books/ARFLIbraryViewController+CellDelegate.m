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
    if (indexPath.section == favoritesSection) {
        
        
        ARFBook * book = [[ARFLibrary sharedLibrary] favoriteBooks][indexPath.row];
        [[ARFLibrary sharedLibrary] markBookFromFavoriteList:book];
        
        [self.tableView reloadData];
        
    }
    else{
        NSString *currentTag = [[ARFLibrary sharedLibrary] tagForIndex:indexPath.section-1];
        ARFBook * book = [[ARFLibrary sharedLibrary] bookForTag:currentTag atIndex:indexPath.row];
        [[ARFLibrary sharedLibrary] markBookFromAlphList:book];
        
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        [indexSet addIndex:0];
        [indexSet addIndex:indexPath.section];
//        [self.tableView beginUpdates];
//        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView endUpdates];
        
        [self.tableView reloadData];
        
        
        
    }
    
}

@end
