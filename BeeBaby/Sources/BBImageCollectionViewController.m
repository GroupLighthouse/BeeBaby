//
// Created by Marlon Santos Constante on 28/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBImageCollectionViewController.h"

@implementation BBImageCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:NSLocalizedString(@"photos", nil)];
    [self.navigationItem setLeftBarButtonItem:[self buildBarButtonItemWithStyleClass:@"camera" andAction:@selector(close:)]];
    [self.navigationItem setRightBarButtonItem:[self buildBarButtonItemWithStyleClass:@"check-circle" andAction:@selector(close:)]];

    [self.collectionView setDataSource:self];
}

- (UIBarButtonItem *)buildBarButtonItemWithStyleClass:(NSString *)styleClass andAction:(SEL)action {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, 25.f)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setStyleClass:styleClass];

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UIImage *image = [self.images objectAtIndex:indexPath.row];

    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    [imageView.layer setCornerRadius:10.f];
    [imageView.layer setMasksToBounds:YES];
    [imageView setStyleClass:@"opaque"];
    [imageView setUserInteractionEnabled:YES];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setImage:image];

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mark:)];
    [imageView addGestureRecognizer:tapRecognizer];

    return cell;
}

- (IBAction)mark:(UITapGestureRecognizer *)tapRecognizer {
    UIImageView *imageView = [tapRecognizer view];
    UIView *check = [[imageView superview] viewWithTag:2];
    if ([imageView styleClass] == @"opaque") {
        [imageView setStyleClass:@"transparent"];
        [check setHidden:NO];
    } else {
        [imageView setStyleClass:@"opaque"];
        [check setHidden:YES];
    }
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end