//
//  ContentViewController.m
//  CCNStatusItemView Example
//
//  Created by Frank Gregor on 28.12.14.
//  Copyright (c) 2014 cocoa:naut. All rights reserved.
//

#import "ContentViewController.h"
#import "CCNStatusItem.h"
#import "AppDelegate.h"
#import "AppPrefsWindowsController.h"
#import "WindowController.h"

@interface ContentViewController ()
@end

@implementation ContentViewController

+ (instancetype)viewController
{
    return [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (IBAction)quit:(NSButton *)sender
{
    NSArray *arg =[NSArray arrayWithObjects:@"aria2c",nil];
    NSTask *task=[[NSTask alloc] init];
    task.launchPath = @"/usr/bin/killall";
    task.arguments = arg;
    [task launch];
    [NSApp terminate:self];
}
- (IBAction)openPreferences:(NSButton *)sender
{
    [[AppPrefsWindowsController sharedPrefsWindowController] showWindow:nil];
}

- (IBAction)openWindow:(NSButton *)sender
{
    /*
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if([currentLanguage  isEqual: @"zh-Hans-CN"])
    {
        self.WindowController = [[WindowController alloc] initWithURL: kStartPage_ZH];
    }
    else
     */
        self.WindowController = [[WindowController alloc] initWithURL: kStartPage];
}



//- (IBAction)switchContentViewControllerAction:(id)sender {
//    [[CCNStatusItem sharedInstance] updateContentViewController:[ContentView2Controller viewController]];
//}

- (CGSize)preferredContentSize {
    return self.view.frame.size;
}

@end
