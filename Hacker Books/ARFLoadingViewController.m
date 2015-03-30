//
//  ARFLoadingViewController.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 4/1/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLoadingViewController.h"
#import "ARFConstants.h"
#import "ARFSerializerUtils.h"
#import "ARFLibrary.h"
#import "ARFLIbraryViewController.h"
#import "ARFBookViewController.h"

@interface ARFLoadingViewController ()

@end

@implementation ARFLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [self.activityIndicator startAnimating];
    _ME_WEAK
    if ([fileManager fileExistsAtPath:[ARFSerializerUtils pathForBooks]]){
        [[ARFLibrary sharedLibrary] decodeBooks];
        [me.activityIndicator stopAnimating];
        [me initializeControllers];
    }
    else{
        [[ARFLibrary sharedLibrary] donwloadBooksWithSuccess:^(BOOL success) {
            [me.activityIndicator stopAnimating];
            if (success) {
                [me initializeControllers];
            }
        }];
    }
}



-(void) initializeControllers{
    
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        
        ARFLIbraryViewController *libraryVC = [[ARFLIbraryViewController alloc] initWithNibName:NSStringFromClass([ARFLIbraryViewController class]) bundle:nil];
        ARFBook *firstBook = [[ARFLibrary sharedLibrary] firstBook];
        ARFBookViewController *bookVC = [[ARFBookViewController alloc] initWithBook:firstBook];
        [libraryVC setDelegate:bookVC];
        UINavigationController *navBook = [[UINavigationController alloc] initWithRootViewController:bookVC];
        UISplitViewController *splitView = [UISplitViewController new];
        splitView.viewControllers = @[libraryVC, navBook];
        [splitView setDelegate:bookVC];
        [self presentViewController:splitView animated:YES completion:nil];
        
    }
    else{
        ARFLIbraryViewController *libraryVC = [[ARFLIbraryViewController alloc] initWithNibName:NSStringFromClass([ARFLIbraryViewController class]) bundle:nil];
        [libraryVC setDelegate:libraryVC];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:libraryVC];
        [self presentViewController:navVC animated:YES completion:nil];
    }
}

@end
