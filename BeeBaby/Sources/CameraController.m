//
//  CameraController.m
//  BeeBaby
//
//  Created by Marlon Santos Constante on 15/01/14.
//  Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "CameraController.h"

@interface CameraController ()

@property (nonatomic) IBOutlet UIView *cameraView;
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic) NSMutableArray *images;

@end

@implementation CameraController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _images = [[NSMutableArray alloc] init];

    [self showImagePickerForCamera];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showImagePickerForCamera {
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType {
    _imagePickerController = [[UIImagePickerController alloc] init];
    [_imagePickerController setDelegate:self];
    [_imagePickerController setSourceType:sourceType];

    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self customCameraInterface];
    }

    [self presentViewController:_imagePickerController animated:NO completion:nil];

}

-(void)customCameraInterface {
    [[NSBundle mainBundle] loadNibNamed:@"CameraView" owner:self options:nil];
    [_cameraView setFrame: [self.view frame]];

    [_imagePickerController setShowsCameraControls:NO];
    [_imagePickerController setCameraOverlayView: _cameraView];

    _cameraView = nil;
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

-(void) savePhotos {
    for (UIImage * image in _images) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    }
    [_images removeAllObjects];
}

@end