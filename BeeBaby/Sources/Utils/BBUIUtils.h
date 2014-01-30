//
// Created by Marlon Santos Constante on 30/01/14.
// Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBUIUtils : NSObject

+ (UIBarButtonItem *)buildBarButtonItemWithTarget:(id)target andAction:(SEL)action andStyleClass:(NSString *)styleClass;

@end