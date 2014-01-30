//
//  main.m
//  BeeBaby
//
//  Created by Marlon Santos Constante on 15/01/14.
//  Copyright (c) 2014 Lighthouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Pixate/Pixate.h>

#import "BBAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        [Pixate licenseKey:@"78BDJ-F8E23-184O0-7SNFS-HQADJ-V21K3-AGDSS-QTF2A-7R7HB-NASRM-P4UDN-E31HG-340QR-FEICN-CN70J-1E" forUser:@"marlonconstante@grouplighthouse.com"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([BBAppDelegate class]));
    }

}