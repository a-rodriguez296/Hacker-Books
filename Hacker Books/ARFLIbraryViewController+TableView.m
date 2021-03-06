//
//  ARFLIbraryViewController+TableView.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/26/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLIbraryViewController+TableView.h"
#import "ARFLIbraryViewController+CellDelegate.h"

@implementation ARFLIbraryViewController (TableView)

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ARFBookCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    ARFBook * currentBook;
        if (indexPath.section>0) {
            NSString *currentTag = [[ARFLibrary sharedLibrary] tagForIndex:indexPath.section-1];
            currentBook = [[ARFLibrary sharedLibrary] bookForTag:currentTag atIndex:indexPath.row];
        }
        else{
            currentBook = [[ARFLibrary sharedLibrary] getFavoriteBooks][indexPath.row];
        }
        
        [cell.lblTitle setText:currentBook.title];
        [cell.lblAuthor setText:[currentBook.authorsList componentsJoinedByString:@","]];
        [cell.btnFavorite setSelected:currentBook.isFavorite];
        [cell setDelegate:self];
        return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ARFBook *currentBook;
    self.selectedIndexPath = indexPath;
        if (indexPath.section == kFavoritesSection) {
            currentBook = [[ARFLibrary sharedLibrary] getFavoriteBooks][indexPath.row];
        }
        else{
            NSString *currentTag = [[ARFLibrary sharedLibrary] tagForIndex:indexPath.section-1];
            currentBook = [[ARFLibrary sharedLibrary] bookForTag:currentTag atIndex:indexPath.row];
        }
    

    //Llamar al delegado
    [self.delegate libraryViewController:self didSelectBook:currentBook];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        if (section>0) {
            NSString *currentTag = [[ARFLibrary sharedLibrary] tagForIndex:section-1];
            return [[ARFLibrary sharedLibrary] bookCountForTag:currentTag];
        }
        else{
            return [[ARFLibrary sharedLibrary] getFavoriteBooks].count;
        }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
        if (section>0) {
            NSArray *sortedArray = [[ARFLibrary sharedLibrary] tags];
            return sortedArray[section-1];
        }
        else
            return @"Favorites";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        NSUInteger tags =[[ARFLibrary sharedLibrary] tags].count;
        return tags+1;
}

@end
