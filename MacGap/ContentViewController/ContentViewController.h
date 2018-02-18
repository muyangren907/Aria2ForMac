//
//  ContentViewController.h
//  CCNStatusItemView Example
//
//  Created by Frank Gregor on 28.12.14.
//  Copyright (c) 2014 cocoa:naut. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class WindowController;

@interface ContentViewController : NSViewController

+ (instancetype)viewController;

@property (weak) IBOutlet NSTabView *tabview;
@property (retain, nonatomic) WindowController *WindowController;


@end
