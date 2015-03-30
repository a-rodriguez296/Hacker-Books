//
//  ARFLoadingViewController.h
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 4/1/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ARFConstants;
@class ARFSerializerUtils;
@class ARFLibrary;
@class ARFLIbraryViewController;
@class ARFBookViewController;


@interface ARFLoadingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
