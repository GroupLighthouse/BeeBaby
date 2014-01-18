//
// Created by Pedro Viegas on 18/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBImagePickerController.h"


@implementation BBImagePickerController {



}

- (id)initWith:(UIImagePickerControllerSourceType)sourceType andView:(UIView*)cameraView{
    self = [super init];
    if (self) {
        [self setDelegate:self];
        [self setSourceType:sourceType];

        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            [self setShowsCameraControls:NO];
            [self setCameraOverlayView:cameraView];
        }
    }
    return self;
}


@end