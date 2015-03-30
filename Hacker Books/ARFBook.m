//
//  ARFBook.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/24/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBook.h"
#import "ARFBooksApiClient.h"

@implementation ARFBook


-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.authorsList = [aDecoder decodeObjectForKey:@"authorsList"];
        self.tagsList = [aDecoder decodeObjectForKey:@"tagsList"];
        self.urlImage = [aDecoder decodeObjectForKey:@"urlImage"];
        self.urlPDF = [aDecoder decodeObjectForKey:@"urlPDF"];
        self.isFavorite = [[aDecoder decodeObjectForKey:@"isFavorite"] boolValue];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.authorsList forKey:@"authorsList"];
    [aCoder encodeObject:self.tagsList forKey:@"tagsList"];
    [aCoder encodeObject:self.urlImage forKey:@"urlImage"];
    [aCoder encodeObject:self.urlPDF forKey:@"urlPDF"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isFavorite] forKey:@"isFavorite"];
}


+(NSData *) getDataWithstURL:(NSString *) stURL{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullCachePath = ((NSURL*)[[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] ).path;
    NSString *fullPath = [fullCachePath stringByAppendingPathComponent:stURL];
    return [NSData dataWithContentsOfFile:fullPath];
}


+(void) donwloadPDFDataWithBook:(ARFBook *) book
                    success:(void (^)(BOOL success, NSString * bookURL))successBlock{
    
    //Averiguar si existe el archivo
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullCachePath = ((NSURL*)[[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] ).path;
    NSString *bookLocalRelativeURL = [[book.urlPDF componentsSeparatedByString:@"/"] lastObject];
    NSString *fullPath = [fullCachePath stringByAppendingPathComponent:bookLocalRelativeURL];
    
    //Sí existe el archivo
    if ([fileManager fileExistsAtPath:fullPath]) {
        successBlock(YES, fullPath);
    }
    else{
        //PEdirle a network que descargue el archivo
        [ARFBooksApiClient donwloadDataWithURL:book.urlPDF success:^(BOOL success, NSData *data) {
            if (success) {
                
                //Guardar el archivo
                [ARFBooksApiClient saveDataOnDiskWithURL:bookLocalRelativeURL withData:data withSuccess:^(BOOL success) {
                    
                    book.urlPDF = bookLocalRelativeURL;
                    
                    //Enviar bloque que ya estoy listo
                    successBlock(success, fullPath);
                    
                }];
            }
        }];
    }
}

@end
