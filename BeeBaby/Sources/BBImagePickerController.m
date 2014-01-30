//
//  BBImagePickerController.m
//  BeeBaby
//
// Created by Pedro Viegas on 18/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBImagePickerController.h"
#import "BBImageCollectionViewController.h"

@interface BBImagePickerController()

    @property (strong, nonatomic) NSMutableArray *images;
    @property (strong, nonatomic) ALAssetsLibrary *library;
    @property (strong, nonatomic) ALAssetsGroup *album;

@end

@implementation BBImagePickerController

static NSString * const ALBUM_NAME = @"BeeBaby";

- (id)initWithSourceType:(UIImagePickerControllerSourceType)sourceType andView:(UIView *)cameraView {
    self = [super init];
    if (self) {
        [self setDelegate:self];
        [self setSourceType:sourceType];

        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            [self setShowsCameraControls:NO];
            [self setCameraOverlayView:cameraView];
        }

        [self setImages: [[NSMutableArray alloc] init]];
        [self setLibrary: [[ALAssetsLibrary alloc] init]];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) createAlbum {
    [self.library addAssetsGroupAlbumWithName:ALBUM_NAME resultBlock:^(ALAssetsGroup *group) {
        NSLog(@"Álbum %@ criado", ALBUM_NAME);
    } failureBlock:^(NSError *error) {
        NSLog(@"Ocorreu um erro ao criar o álbum %@", ALBUM_NAME);
    }];
}

- (void) loadAlbum {
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:ALBUM_NAME]) {
            self.album = group;
            *stop = YES;
            NSLog(@"Álbum %@ encontrado", ALBUM_NAME);
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Ocorreu um erro ao buscar o álbum %@", ALBUM_NAME);
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.images addObject:image];
}

- (void)savePhoto:(NSDictionary *)info {
    [self createAlbum];
    [self loadAlbum];

    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

    [self.library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error != nil) {
            [self.library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
              [self.album addAsset:asset];
            } failureBlock:^(NSError *error) {
                NSLog(@"Ocorreu um erro ao salvar a foto no álbum %@", ALBUM_NAME);
            }];
        } else {
            NSLog(@"Ocorreu um erro ao salvar a foto no álbum %@", ALBUM_NAME);
        }
    }];
}

-(void)openGallery {
    [self createAlbum];
    [self loadAlbum];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBImageCollectionViewController *imageCollectionView = [storyboard instantiateViewControllerWithIdentifier:@"ImageCollectionView"];
    [imageCollectionView setImages:self.images];

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