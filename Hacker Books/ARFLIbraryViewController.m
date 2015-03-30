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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMarkBook:) name:kDidMarkBookNotification object:nil];
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

-(void) didMarkBook:(NSNotification *) notification{
    
    NSDictionary *userInfo = notification.userInfo;
    ARFBook * book = [userInfo objectForKey:@"book"];
    
    
    //Logica:
    //Solamente hay q hacer cambios en el caso en el que el libro quede en un estado (favorite o !favorite) diferente del que salió en cellDidSelect...
    //El estado en el que salió se puede deducir del indexPath.section q esta guardado en la variable self.selectedIndexPath
    if (book.isFavorite && self.selectedIndexPath.section != kFavoritesSection) {
        
        //Ir a la seccion q tengo guardada en el indexpath
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView deleteRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView endUpdates];

    }
    else if(!book.isFavorite && self.selectedIndexPath.section == kFavoritesSection){
        
    }
    
//    [self.tableView reloadData];
    
}




-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
