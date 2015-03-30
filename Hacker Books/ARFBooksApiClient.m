//
//  ARFBooksApiClient.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBooksApiClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "ARFBook+Parse.h"
#import "ARFConstants.h"
#import "ARFSerializerUtils.h"

@implementation ARFBooksApiClient

+(void) requestBooksWithURL:(NSString *) stURL
                withSuccess:(void (^) (BOOL success)) successBlock{

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:stURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray * responseArray = [NSMutableArray new];
        NSLog(@"%@", NSStringFromClass([responseObject class]));
        NSError *errorJson;
        
        NSArray* objectsArray = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&errorJson];
        
        //Parsing de la información que viene en el json
        for (NSDictionary *bookDictionary in objectsArray) {
            ARFBook *book = [ARFBook new];
            [book parseBookWithData:bookDictionary];
            [responseArray addObject:book];
        }
        NSArray *finalArray = [NSArray arrayWithArray:responseArray];
        //Descargar de las imagenes de cada uno de los libros
        [self donwloadPicturesWithArray:finalArray withSuccess:^(BOOL success) {
            if (success) {
                
                //Acá hay que guardar
                [self serializeDataWithArray:finalArray withSuccess:^(BOOL success) {
                    if (success) {
                        //Volvemos al thread principal
                        dispatch_async(dispatch_get_main_queue(), ^{
                            successBlock(success);
                        });
                    }
                }];
            }
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


+(void) serializeDataWithArray:(NSArray *) booksArray
                   withSuccess:(void (^) (BOOL  success)) successBlock{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        BOOL success= [NSKeyedArchiver archiveRootObject:booksArray  toFile:[ARFSerializerUtils pathForBooks]];
        if (success) {
            successBlock(YES);
        }
        else{
            successBlock(NO);
        }
    });
    
    
    
}

+(void) donwloadPicturesWithArray:(NSArray *) picturesArray
                      withSuccess:(void (^) (BOOL  success)) successBlock{

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __block NSUInteger counter = picturesArray.count;
    for (ARFBook *book in picturesArray) {
        NSString * pictureURL =book.urlImage;
        [manager GET:pictureURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData * data = responseObject;
            NSArray *stURLArray = [pictureURL componentsSeparatedByString:@"/"];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            NSString *documentsPath = [paths lastObject];
            NSString *filePath = [documentsPath stringByAppendingPathComponent:[stURLArray lastObject]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                BOOL success = [data writeToFile:filePath atomically:YES];
                if (success) {
                    book.urlImage = [stURLArray lastObject];
                    counter--;
                    if (counter==0)
                        successBlock (YES);
                }
                else
                    successBlock(NO);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            successBlock(NO);
        }];
    }
}


+(void) donwloadDataWithURL:(NSString *) url
                   success:(void(^)(BOOL success, NSData *data)) successBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *) responseObject;
        successBlock(YES, data);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        successBlock(NO,nil);
    }];
}


+(void) saveDataOnDiskWithURL:(NSString *) url withData:(NSData *)data
                  withSuccess:(void(^) (BOOL success)) successBlock{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:url];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL success = [data writeToFile:filePath atomically:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                successBlock (YES);
            }
            else
                successBlock(NO);
        });
        
    });
}

@end
