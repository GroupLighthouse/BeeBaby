//
//  BBImageUtils.m
//  BeeBaby
//
//  Created by Marlon Santos Constante on 03/02/14.
//  Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBImageUtils.h"
#import "BBFileUtils.h"

@implementation BBImageUtils

static NSString * const PHOTO_PREFIX = @"photo_";

static NSString * const THUMBNAIL_PREFIX = @"thumbnail_";

static NSString * const IMAGE_IDENTIFIER = @"ImageIdentifier";

static BBImageUtils *mainInstance;

+(void)initialize {
    if (!mainInstance) {
        mainInstance = [[BBImageUtils alloc] init];
    }
}

+(BBImageUtils *)mainInstance {
    return mainInstance;
}

-(void)saveImage:(UIImage *)originalImage {
    @autoreleasepool {
        NSData *photo = UIImageJPEGRepresentation(originalImage, 0.95f);
        NSData *thumbnail = UIImageJPEGRepresentation([self thumbnailImage:originalImage], 0.95f);

        [photo writeToFile:[self nextImagePathWithPrefix:BBImagePrefixPhoto] atomically:YES];
        [thumbnail writeToFile:[self nextImagePathWithPrefix:BBImagePrefixThumbnail] atomically:YES];

        [self increaseImageIdentifier];
    }
}

-(void)deleteImagesWithPrefix:(BBImagePrefix)imagePrefix {
    for (NSString *filePath in [[BBFileUtils mainInstance] filePathsWithPrefix:[self prefixName:imagePrefix]]) {
        [[BBFileUtils mainInstance] deleteFileByPath:filePath];
    }
}

-(NSArray *)loadImagesWithPrefix:(BBImagePrefix)imagePrefix {
    NSMutableArray *images = [[NSMutableArray alloc] init];

    for (NSString *filePath in [[BBFileUtils mainInstance] filePathsWithPrefix:[self prefixName:imagePrefix]]) {
        [images addObject:[UIImage imageWithContentsOfFile:filePath]];
    }

    return images;
}

-(UIImage *)thumbnailImage:(UIImage *)originalImage {
    CGSize originalSize = [originalImage size];
    CGSize size = CGSizeMake(originalSize.width / 20, originalSize.height / 20);

    UIGraphicsBeginImageContext(size);
    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

-(NSString *)prefixName:(BBImagePrefix)imagePrefix {
    switch (imagePrefix) {
        case BBImagePrefixPhoto:
            return PHOTO_PREFIX;
        case BBImagePrefixThumbnail:
            return THUMBNAIL_PREFIX;
        default:
            [NSException raise:@"Prefixo inválido" format:@"Deve ser informado um prefixo válido"];
    }
}

-(NSString *)nextImagePathWithPrefix:(BBImagePrefix)imagePrefix {
    NSString *documentsDirectory = [[BBFileUtils mainInstance] documentsDirectory];

    NSString *fileName = [NSString stringWithFormat:[[self prefixName:imagePrefix] stringByAppendingString:@"%d.jpg"], [self imageIdentifier]];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:fileName];

    return imagePath;
}

-(NSInteger)imageIdentifier {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger imageIdentifier = [userDefaults integerForKey:IMAGE_IDENTIFIER];
    if (!imageIdentifier) {
        imageIdentifier = 1;
    }
    return imageIdentifier;
}

-(void)increaseImageIdentifier {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:[self imageIdentifier] + 1 forKey:IMAGE_IDENTIFIER];
    [userDefaults synchronize];
}

@end
