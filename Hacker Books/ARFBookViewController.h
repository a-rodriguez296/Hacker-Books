//
//  ARFBookViewController.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARFBook.h"
#import "ARFLIbraryViewController.h"

@interface ARFBookViewController : UIViewController <UISplitViewControllerDelegate, ARFLibraryViewControllerDelegate>





-(id) initWithBook:(ARFBook *) book;

@end
