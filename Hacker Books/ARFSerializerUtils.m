//
//  ARFSerializerUtils.m
//  Hacker Books
//
//  Created by Alejandro Rodriguez on 3/30/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFSerializerUtils.h"
#import "ARFConstants.h"

@implementation ARFSerializerUtils

+(NSString *)pathForBooks{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:kDataFileName];
    return filePath;
}

@end
