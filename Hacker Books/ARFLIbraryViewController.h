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

@class ARFSerializerUtils;
@class ARFBookViewController;

static NSString * const cellIdentifier = @"Cell";
static const NSUInteger kFavoritesSection = 0;



@class ARFLIbraryViewController;



@protocol ARFLibraryViewControllerDelegate <NSObject>

//Si lo implemento yo, hay que hacer push.
//Si lo implementa el hijo, solo hay q hacer sync model.


@required
-(void) libraryViewController:(ARFLIbraryViewController *) libraryVC didSelectBook:(ARFBook *) book;



@end


@interface ARFLIbraryViewController : UIViewController  <ARFLibraryViewControllerDelegate>


@property(weak, nonatomic) id<ARFLibraryViewControllerDelegate> delegate;



@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;


-(NSIndexPath *) indexPathWithSender:(UIView *) view;

@end
