//
// Created by Marlon Santos Constante on 30/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBTimelineTableViewController.h"
#import "BBUIUtils.h"

@interface BBTimelineTableViewController()

@end

@implementation BBTimelineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:NSLocalizedString(@"timeline", nil)];
    [self.navigationItem setLeftBarButtonItem:[BBUIUtils buildBarButtonItemWithTarget:self andAction:@selector(close:) andStyleClass:@"camera"]];
    [self.navigationItem setRightBarButtonItem:[BBUIUtils buildBarButtonItemWithTarget:self andAction:@selector(close:) andStyleClass:@"refresh"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.timelines count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    UIImage *image = [self.timelines objectAtIndex:indexPath.row];

    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setImage:image];

    return cell;
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end