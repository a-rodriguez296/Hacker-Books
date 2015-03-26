//
//  ARFLIbraryViewController.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARFCellDelegate.h"

@interface ARFLIbraryViewController : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate,ARFCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
