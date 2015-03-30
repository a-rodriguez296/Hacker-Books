//
//  ARFLIbraryViewController.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARFBook.h"
#import "ARFBookCell.h"
#import "ARFLibrary.h"

static NSString * const cellIdentifier = @"Cell";
static const NSUInteger kFavoritesSection = 0;

@interface ARFLIbraryViewController : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;


-(NSIndexPath *) indexPathWithSender:(UIView *) view;

@end
