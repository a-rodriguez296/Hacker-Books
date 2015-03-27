//
//  ARFLIbraryViewController.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLIbraryViewController.h"

@interface ARFLIbraryViewController ()



@end

@implementation ARFLIbraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"Hacker Library"];
    
    
    [[ARFLibrary sharedLibrary] donwloadBooksWithSuccess:^(NSArray *books) {
        [self.tableView reloadData];
    } failure:^(NSString *error) {
        //Caso de error
    }];
    

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARFBookCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSIndexPath *) indexPathWithSender:(UIView *) view{
    while (view != nil) {
        if ([view isKindOfClass:[ARFBookCell class]]) {
            return [self.tableView indexPathForCell:(ARFBookCell *)view];
        } else {
            view = [view superview];
        }
    }
    return nil;
}



@end
