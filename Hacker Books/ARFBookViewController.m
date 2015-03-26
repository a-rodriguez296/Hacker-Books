//
//  ARFBookViewController.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBookViewController.h"

@interface ARFBookViewController ()

@property (nonatomic, strong) ARFBook *book;

@end

@implementation ARFBookViewController

-(id) initWithBook:(ARFBook *)book{
    if (self = [super init]) {
        _book= book;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.lblTitle setText:self.book.title];
    [self.lblAuthors setText:[self.book.authorsList componentsJoinedByString:@","]];
    [self.btnFavorite setSelected:self.book.isFavorite];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onTouchFavorite:(id)sender {
}

@end
