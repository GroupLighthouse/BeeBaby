//
//  BBImageUtils.h
//  BeeBaby
//
//  Created by Marlon Santos Constante on 03/02/14.
//  Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BBImagePrefix) {
    BBImagePrefixPhoto,
    BBImagePrefixThumbnail
};

@interface BBImageUtils : NSObject

+(BBImageUtils *)mainInstance;

-(void)saveImage:(UIImage *)originalImage;

-(void)deleteImagesWithPrefix:(BBImagePrefix)imagePrefix;

-(NSArray *)loadImagesWithPrefix:(BBImagePrefix)imagePrefix;

@end
