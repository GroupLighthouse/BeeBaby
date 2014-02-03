//
//  BBImagePickerController.m
//  BeeBaby
//
// Created by Pedro Viegas on 18/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBImagePickerController.h"
#import "BBImageCollectionViewController.h"
#import "BBImageUtils.h"

@implementation BBImagePickerController

- (id)initWithSourceType:(UIImagePickerControllerSourceType)sourceType andView:(UIView *)cameraView {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [NSThread detachNewThreadSelector:@selector(saveImage:) toTarget:[BBImageUtils mainInstance] withObject:image];
}

-(void)openGallery {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBImageCollectionViewController *imageCollectionView = [storyboard instantiateViewControllerWithIdentifier:@"ImageCollectionView"];

    UINavigationController *navigationController = [[UINavigationController alloc] init];
    [navigationController pushViewController:imageCollectionView animated:NO];

    [self presentViewController:navigationController animated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return nil;
}

@end