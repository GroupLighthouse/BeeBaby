//
// Created by Marlon Santos Constante on 30/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import "BBImageCollectionViewController.h"
#import "BBUIUtils.h"

@implementation BBUIUtils

+ (UIBarButtonItem *)buildBarButtonItemWithTarget:(id)target andAction:(SEL)action andStyleClass:(NSString *)styleClass {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, 25.f)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setStyleClass:styleClass];

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}

@end