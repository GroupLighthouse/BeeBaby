//
// Created by Marlon Santos Constante on 28/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBImageCollectionViewController.h"
#import "BBUIUtils.h"
#import "BBTimelineTableViewController.h"
#import "BBImageUtils.h"

@interface BBImageCollectionViewController()

    @property (strong, nonatomic) NSArray *images;

@end

@implementation BBImageCollectionViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setImages:[[BBImageUtils mainInstance] loadImagesWithPrefix:BBImagePrefixThumbnail]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:NSLocalizedString(@"photos", nil)];
    [self.navigationItem setLeftBarButtonItem:[BBUIUtils buildBarButtonItemWithTarget:self andAction:@selector(close:) andStyleClass:@"camera"]];
    [self.navigationItem setRightBarButtonItem:[BBUIUtils buildBarButtonItemWithTarget:self andAction:@selector(openTimeline:) andStyleClass:@"check-circle"]];

    [self.collectionView setDataSource:self];
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
    UIImageView *imageView = (UIImageView *)[tapRecognizer view];
    UIView *check = [[imageView superview] viewWithTag:2];
    if ([[imageView styleClass] isEqual: @"opaque"]) {
        [imageView setStyleClass:@"transparent"];
        [check setHidden:NO];
    } else {
        [imageView setStyleClass:@"opaque"];
        [check setHidden:YES];
    }
}

- (IBAction)openTimeline:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BBTimelineTableViewController *timelineTableView = [storyboard instantiateViewControllerWithIdentifier:@"TimelineTableView"];
    [timelineTableView setTimelines:self.images];

    UINavigationController *navigationController = [[UINavigationController alloc] init];
    [navigationController pushViewController:timelineTableView animated:NO];

    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end