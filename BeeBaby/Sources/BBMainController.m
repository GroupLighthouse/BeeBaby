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

@property(strong, nonatomic) IBOutlet UIView *cameraView;
@property(nonatomic) UIImagePickerController *imagePickerController;
@property(nonatomic) NSMutableArray *images;

@end

@implementation BBMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    _images = [[NSMutableArray alloc] init];
    [self showImagePickerForCamera];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showImagePickerForCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else {
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [_images addObject:image];

    NSLog(@"Número de fotos: %d", [_images count]);

    if ([_images count] == 10) {
        [self savePhotos];
        _imagePickerController = nil;
    }
}

- (void)savePhotos {
    for (UIImage *image in _images) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    }
    [_images removeAllObjects];
}

@end