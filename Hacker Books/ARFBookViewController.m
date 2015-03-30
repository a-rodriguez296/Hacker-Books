//
//  ARFBookViewController.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/25/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBookViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ReaderDocument.h"
#import "ReaderViewController.h"

@class ARFLibrary;
@class ARFBook;
@class ARFLIbraryViewController;

@interface ARFBookViewController () <ReaderViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgBook;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthors;
@property (weak, nonatomic) IBOutlet UILabel *lblTaglist;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


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
    
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectBookInTable:) name:kDidSelectBookInTableNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupView];
    
    
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
}

-(void) setupView{
    [self.lblTitle setText:self.book.title];
    [self.lblAuthors setText:[self.book.authorsList componentsJoinedByString:@","]];
    [self.lblTaglist setText:[self.book.tagsList componentsJoinedByString:@","]];
    [self.btnFavorite setSelected:self.book.isFavorite];
    
    [self setTitle:self.book.title];
    
    //Imagen
    [self.imgBook setImage:[UIImage imageWithData:[ARFBook getDataWithstURL:self.book.urlImage]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTouchFavorite:(id)sender {
    
    //Comunicar cambio de estado al modelo
    if (!self.book.isFavorite) {
        [[ARFLibrary sharedLibrary] markBookFromAlphList:self.book withNotificationOptions:ARFNeedsToBeNotified];
    }
    else{
        [[ARFLibrary sharedLibrary] markBookFromFavoriteList:self.book withNotificationOptions:ARFNeedsToBeNotified];
    }

    [sender setSelected:self.book.isFavorite];
}

- (IBAction)viewPDF:(id)sender {
    
//    NSString *pdfUrl = self.book.urlPDF;
    
    _ME_WEAK
    [self.activityIndicator startAnimating];
    [ARFBook donwloadPDFDataWithBook:self.book success:^(BOOL success,NSString * bookURL) {
        if (success) {
            
            ReaderDocument *readerDoc = [[ReaderDocument alloc]initWithFilePath:bookURL password:nil];
            ReaderViewController *readerVC = [[ReaderViewController alloc]initWithReaderDocument:readerDoc];
            [readerVC setDelegate:self];
            [self.navigationController.navigationBar setHidden:YES];
            [self.navigationController pushViewController:readerVC animated:YES];

        }
        [me.activityIndicator stopAnimating];
    }];
}


#pragma mark ARFLIbraryViewControllerDelegate
-(void)libraryViewController:(ARFLIbraryViewController *)libraryVC didSelectBook:(ARFBook *)book{
   
    self.book = book;
    [self setupView];
    
    for (id vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ReaderViewController class]]) {
            //Estoy en pdf
            
            //Hacer pop del readerVC actual
            [self dismissReaderViewController:vc];
            
            [self viewPDF:nil];
        }
    }
}


#pragma mark ARFLibraryViewControllerDelegate
-(void)dismissReaderViewController:(ReaderViewController *)viewController{
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
