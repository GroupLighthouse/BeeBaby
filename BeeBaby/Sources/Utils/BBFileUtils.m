//
//  BBFileUtils.m
//  BeeBaby
//
//  Created by Marlon Santos Constante on 01/02/14.
//  Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBFileUtils.h"

@implementation BBFileUtils

static BBFileUtils *mainInstance;

+(void)initialize {
    if (!mainInstance) {
        mainInstance = [[BBFileUtils alloc] init];
    }
}

+(BBFileUtils *)mainInstance {
    return mainInstance;
}

-(void)deleteFileByPath:(NSString *)filePath {
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"Ocorreu um erro ao remover o arquivo \"%@\". Descrição: %@", filePath, error.localizedDescription);
    }
}

-(NSArray *)filePathsWithPrefix:(NSString *)prefix {
    NSMutableArray *filePaths = [[NSMutableArray alloc] init];
    NSString *documentsDirectory = [self documentsDirectory];

    NSError *error;
    NSArray *fileNames = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory error:&error];
    if (error) {
        NSLog(@"Ocorreu um erro ao buscar o nome dos arquivos. Descrição: %@", error.localizedDescription);
    }

    for (NSString *fileName in fileNames) {
        if ([fileName hasPrefix:prefix]) {
            [filePaths addObject:[documentsDirectory stringByAppendingPathComponent:fileName]];
        }
    }

    return filePaths;
}

-(NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

@end
