//
//  BBImagePickerController.m
//  BeeBaby
//
// Created by Pedro Viegas on 18/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBImagePickerController.h"

@interface BBImagePickerController()

    @property (nonatomic) NSMutableArray *images;
    @property (nonatomic) ALAssetsLibrary *library;
    @property (nonatomic) ALAssetsGroup *album;

@end

@implementation BBImagePickerController

static NSString * const ALBUM_NAME = @"BeeBaby";

- (id)initWith:(UIImagePickerControllerSourceType)sourceType andView:(UIView *)cameraView {
    self = [super init];
    if (self) {
        [self setDelegate:self];
        [self setSourceType:sourceType];

        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            [self setShowsCameraControls:NO];
            [self setCameraOverlayView:cameraView];
        }

        _images = [[NSMutableArray alloc] init];
        _library = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

- (void) createAlbum {
    [_library addAssetsGroupAlbumWithName:ALBUM_NAME resultBlock:^(ALAssetsGroup *group) {
        NSLog(@"Álbum %@ criado", ALBUM_NAME);
    } failureBlock:^(NSError *error) {
        NSLog(@"Ocorreu um erro ao criar o álbum %@", ALBUM_NAME);
    }];
}

- (void) loadAlbum {
    [_library enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:ALBUM_NAME]) {
            _album = group;
            *stop = YES;
            NSLog(@"Álbum %@ encontrado", ALBUM_NAME);
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Ocorreu um erro ao buscar o álbum %@", ALBUM_NAME);
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self savePhoto: info];
}

- (void)savePhoto:(NSDictionary *)info {
    [self createAlbum];
    [self loadAlbum];

    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSDictionary *metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];

    [_library writeImageToSavedPhotosAlbum:[image CGImage] metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error.code == 0) {
            [_library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
              [_album addAsset:asset];
            } failureBlock:^(NSError *error) {
                NSLog(@"Ocorreu um erro ao salvar a foto no álbum %@", ALBUM_NAME);
            }];
        } else {
            NSLog(@"Ocorreu um erro ao salvar a foto no álbum %@", ALBUM_NAME);
        }
    }];

    [_images addObject:image];
    _album = nil;
}

@end