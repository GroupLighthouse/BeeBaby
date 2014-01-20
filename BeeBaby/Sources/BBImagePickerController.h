//
//  BBImagePickerController.h
//  BeeBaby
//
// Created by Pedro Viegas on 18/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface BBImagePickerController : UIImagePickerController <UIImagePickerControllerDelegate>

- (id)initWith:(UIImagePickerControllerSourceType)sourceType andView:(UIView *)cameraView;

@end