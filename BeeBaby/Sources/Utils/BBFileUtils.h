//
//  BBFileUtils.h
//  BeeBaby
//
//  Created by Marlon Santos Constante on 01/02/14.
//  Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBFileUtils : NSObject

+(BBFileUtils *)mainInstance;

-(void)deleteFileByPath:(NSString *)filePath;

-(NSArray *)filePathsWithPrefix:(NSString *)prefix;

-(NSString *)documentsDirectory;

@end
