//
//  BBMainController.m
//  BeeBaby
//
//  Created by Marlon Santos Constante on 15/01/14.
//  Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBMainController.h"
#import "BBImagePickerController.h"

@interface BBMainController ()

@property (strong, nonatomic) IBOutlet UIView *cameraView;
@property (nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation BBMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showImagePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showImagePicker {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType {
    _imagePickerController = [[BBImagePickerController alloc] initWith:sourceType andView:_cameraView];
    [self presentViewController:_imagePickerController animated:NO completion:nil];

}

- (IBAction)takePhoto:(id)sender {
    [_imagePickerController takePicture];
}

@end