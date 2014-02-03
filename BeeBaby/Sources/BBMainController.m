//
//  BBMainController.m
//  BeeBaby
//
//  Created by Marlon Santos Constante on 15/01/14.
//  Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBMainController.h"
#import "BBImagePickerController.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface BBMainController ()

@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (strong, nonatomic) BBImagePickerController *imagePickerController;

@end

@implementation BBMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self beginGeneratingDeviceOrientationNotifications];
    [self showImagePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)beginGeneratingDeviceOrientationNotifications {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotation:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)didRotation:(NSNotification *)notification {
    [UIView animateWithDuration:0.2f animations:^{
        int rotate;
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        switch (orientation) {
            case UIDeviceOrientationLandscapeLeft:
                rotate = 90;
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                rotate = 180;
                break;
            case UIDeviceOrientationLandscapeRight:
                rotate = 270;
                break;
            default:
                rotate = 0;
                break;
        }
        CGAffineTransform transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(rotate));
        for (UIView *view in [[self.view viewWithTag:1] subviews]) {
            [view setTransform:transform];
            [view setTransform:transform];
        }
    }];
}

- (void)showImagePicker {
    if ([BBImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType {
    self.imagePickerController = [[BBImagePickerController alloc] initWithSourceType:sourceType andView:self.cameraView];
    [self presentViewController:self.imagePickerController animated:NO completion:nil];
}

- (IBAction)takePhoto:(id)sender {
    [self.view setBackgroundColor:[[UIColor alloc] initWithRed:255.f green:255.f blue:255.f alpha:0.7f]];
    [self.imagePickerController takePicture];
    [UIView animateWithDuration:0.3f animations:^{
        [self.view setBackgroundColor:[UIColor clearColor]];
    }];
}

- (IBAction)openGallery:(id)sender {
    [self.imagePickerController openGallery];
}

@end