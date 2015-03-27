//
//  ARFLIbraryViewController+TableView.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/26/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLIbraryViewController+TableView.h"
#import "ARFBookViewController.h"
#import "ARFLIbraryViewController+CellDelegate.h"

@implementation ARFLIbraryViewController (TableView)

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ARFBookCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    ARFBook * currentBook;
    if (![self isSearchDisplayTableView:tableView]) {
        if (indexPath.section>0) {
            NSString *currentTag = [[ARFLibrary sharedLibrary] tagForIndex:indexPath.section-1];
            currentBook = [[ARFLibrary sharedLibrary] bookForTag:currentTag atIndex:indexPath.row];
        }
        else{
            currentBook = [[ARFLibrary sharedLibrary] favoriteBooks][indexPath.row];
        }
        
        [cell.lblTitle setText:currentBook.title];
        [cell.lblAuthor setText:[currentBook.authorsList componentsJoinedByString:@","]];
        [cell.btnFavorite setSelected:currentBook.isFavorite];
        [cell setDelegate:self];
        return cell;
    }
    else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
        currentBook = [[ARFLibrary sharedLibrary] sortedBooksWithTitle][indexPath.row];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        }
        [cell.textLabel setText:currentBook.title];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ARFBook *currentBook;
    if (![self isSearchDisplayTableView:tableView]) {
        NSString *currentTag = [[ARFLibrary sharedLibrary] tagForIndex:indexPath.section];
        currentBook = [[ARFLibrary sharedLibrary] bookForTag:currentTag atIndex:indexPath.row];
    }
    else{
        currentBook =  [[ARFLibrary sharedLibrary] sortedBooksWithTitle][indexPath.row];
    }
    
    ARFBookViewController *bookVC = [[ARFBookViewController alloc] initWithBook:currentBook];
    [self.navigationController pushViewController:bookVC animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (![self isSearchDisplayTableView:tableView]) {
        if (section>0) {
            NSString *currentTag = [[ARFLibrary sharedLibrary] tagForIndex:section-1];
            return [[ARFLibrary sharedLibrary] bookCountForTag:currentTag];
        }
        else{
            return [[ARFLibrary sharedLibrary] favoriteBooks].count;
        }
    }
    else
        return  [[ARFLibrary sharedLibrary] sortedBooksWithTitle].count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (![self isSearchDisplayTableView:tableView]) {
        if (section>0) {
            NSArray *sortedArray = [[ARFLibrary sharedLibrary] tags];
            return sortedArray[section-1];
        }
        else
            return @"Favorites";
    }
    else{
        return @"";
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (![self isSearchDisplayTableView:tableView]) {
        NSUInteger tags =[[ARFLibrary sharedLibrary] tags].count;
        return tags+1;
    }
    else
        return 1;
}


#pragma mark Aux Methods

-(BOOL) isSearchDisplayTableView:(UITableView *) tableView{
    return ![tableView isEqual:self.tableView];
}
@end
