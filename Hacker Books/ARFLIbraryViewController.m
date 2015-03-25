//
//  ARFLIbraryViewController.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFLIbraryViewController.h"
#import "ARFLibrary.h"
#import "ARFBook.h"
#import "ARFBookCell.h"

static NSString * const cellIdentifier = @"Cell";

@interface ARFLIbraryViewController ()

@property(nonatomic, strong) NSArray * books;

@end

@implementation ARFLIbraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[ARFLibrary sharedLibrary] donwloadBooksWithSuccess:^(NSArray *books) {
        self.books = books;
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ARFBook * currentBook = [[ARFLibrary sharedLibrary] libraryBooks][indexPath.row];
    ARFBookCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    
    [cell.lblAuthor setText:currentBook.title];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.books.count;
}





@end
