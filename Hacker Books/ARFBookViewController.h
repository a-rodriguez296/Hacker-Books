//
//  ARFBookViewController.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARFBook.h"

@interface ARFBookViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *imgBook;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthors;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;


-(id) initWithBook:(ARFBook *) book;

@end
