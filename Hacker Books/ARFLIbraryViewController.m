//
//  ARFLIbraryViewController.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLIbraryViewController.h"
#import "ARFSerializerUtils.h"
#import "ARFBookViewController.h"

@interface ARFLIbraryViewController ()



@end

@implementation ARFLIbraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"Hacker Library"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    

    _ME_WEAK
    if ([fileManager fileExistsAtPath:[ARFSerializerUtils pathForBooks]]){
        [[ARFLibrary sharedLibrary] decodeBooks];
        [me.tableView reloadData];
    }
    else{
        [[ARFLibrary sharedLibrary] donwloadBooksWithSuccess:^(BOOL success) {
            if (success) {
                [me.tableView reloadData];
            }
        }];
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARFBookCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMarkBook:) name:kDidMarkBookAsFavoriteNotification object:nil];
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



#pragma mark ARFLibraryViewControllerDelegate
-(void) libraryViewController:(ARFLIbraryViewController *) libraryVC didSelectBook:(ARFBook *) book{
    
    ARFBookViewController *bookVC = [[ARFBookViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:bookVC animated:YES];
}






#pragma mark Notifications
-(void) didMarkBook:(NSNotification *) notification{
    [self.tableView reloadData];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
