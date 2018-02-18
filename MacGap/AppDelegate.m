//
//  AppDelegate.m
//  MG
//
//  Created by Tim Debo on 5/19/14.
//
//

#import "AppDelegate.h"
#import "WindowController.h"
#import "AppPrefsWindowsController.h"
#import "CCNStatusItem.h"
#import "CCNStatusItemWindowConfiguration.h"
#import "ContentViewController.h"



@implementation AppDelegate

+ (void)initialize {
    if ( self == [AppDelegate class] ) {
        NSDictionary *defaultValues = @{Aria2ForMac_MAX_CONCURRENT_DOWNLOADS: @(10),
                                        Aria2ForMac_MAX_DOWNLOAD_SPEED:@(0),
                                        Aria2ForMac_MAX_UPLOAD_SPEED:@(0),
                                        Aria2ForMac_MAX_PER_DOWNLOAD_SPEED:@(0),
                                        Aria2ForMac_MAX_PER_UPLOAD_SPEED:@(0),
                                        Aria2ForMac_PROXY_STATE:@(NO),
                                        Aria2ForMac_USER_STATE:@(NO),
                                        Aria2ForMac_DISK_CACHE:@(0),
                                        Aria2ForMac_MAX_CONNECTION_PER_SERVER:@(16),
                                        Aria2ForMac_MIN_SPLIT_SIZE:@(1024),
                                        Aria2ForMac_SPLIT:@(16),
                                        Aria2ForMac_ALLOW_OVERWRITE_STATE:@("true"),
                                        Aria2ForMac_AUTO_FILE_RENAMEING_STATE:@("true"),
                                        Aria2ForMac_CONTIUNE:@("true"),
                                        Aria2ForMac_LOG_FILE_STATE:@(NO),
                                        Aria2ForMac_MAX_TRIES:@(0),
                                        Aria2ForMac_RETRY_WAIT:@(5),
                                        };
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
        [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:defaultValues];
    }
}
- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    [self startAria2];
}

-(BOOL)applicationShouldHandleReopen:(NSApplication*)application
                   hasVisibleWindows:(BOOL)visibleWindows{
    if(!visibleWindows){
        [self.windowController.window makeKeyAndOrderFront: nil];
    }
    return YES;
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    bool statusBarState = [[NSUserDefaults standardUserDefaults] boolForKey:Aria2ForMac_STATUS_BAR_STATE];
    if(!statusBarState)
    {
        /*
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        if([currentLanguage  isEqual: @"zh-Hans-CN"])
        {
            self.windowController = [[WindowController alloc] initWithURL: kStartPage_ZH];
        }
        else
         */
            self.windowController = [[WindowController alloc] initWithURL: kStartPage];
    [self.windowController setWindowParams];
    [self.windowController showWindow:self];
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    }
    else
    //[self showStatusBar];
    [[CCNStatusItem sharedInstance] presentStatusItemWithImage:[NSImage imageNamed:@"aria2@2x.png"]
                                             contentViewController:[ContentViewController viewController]];
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center
     shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

-(void)applicationWillTerminate:(NSNotification *)aNotification
{
    [self closeAria2];
}

-(void)startAria2
{
    NSString *startAriaPath = [[NSBundle mainBundle] pathForResource:@"startAria2" ofType:@"sh"];
    NSString *dir = [[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_SAVE_PATH];
    NSString *proxyHost = [[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_PROXY_HOST];
    NSInteger proxyPort = [[NSUserDefaults standardUserDefaults] integerForKey:Aria2ForMac_PROXY_PORT];
    NSString *proxyUser = [[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_PROXY_USER];
    NSString *proxyPassword = [[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_PROXY_PASSWORD];
    NSString *proxyType = [[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_PROXY_TYPE];

    bool proxyState = [[NSUserDefaults standardUserDefaults] boolForKey:Aria2ForMac_PROXY_STATE];
    bool userState = [[NSUserDefaults standardUserDefaults] boolForKey:Aria2ForMac_USER_STATE];
    
    
    if (!dir || [dir length] == 0)
    {
        dir = [@"~/Downloads" stringByExpandingTildeInPath];
    }
    
    double maxDownloadSpeedIn = [[NSUserDefaults standardUserDefaults] doubleForKey:Aria2ForMac_MAX_DOWNLOAD_SPEED];
    NSString *maxDownloadSpeedStr = [NSString stringWithFormat:@"%d", (int)(maxDownloadSpeedIn * 1000)];
    
    double maxPerDownloadSpeedIn = [[NSUserDefaults standardUserDefaults] doubleForKey:Aria2ForMac_MAX_PER_DOWNLOAD_SPEED];
    NSString *maxPerDownloadSpeedStr = [NSString stringWithFormat:@"%d", (int)(maxPerDownloadSpeedIn * 1000)];
    
    double maxUploadSpeedIn = [[NSUserDefaults standardUserDefaults] doubleForKey:Aria2ForMac_MAX_UPLOAD_SPEED];
    NSString *maxUploadSpeedStr = [NSString stringWithFormat:@"%d", (int)maxUploadSpeedIn];
    
    double maxPerUploadSpeedIn = [[NSUserDefaults standardUserDefaults] doubleForKey:Aria2ForMac_MAX_PER_UPLOAD_SPEED];
    NSString *maxPerUploadSpeedStr = [NSString stringWithFormat:@"%d", (int)maxPerUploadSpeedIn];
    
    NSString *shCommand = [NSString stringWithFormat:@"%@ --dir=%@ --conf-path=%@  --input-file=%@ --save-session=%@  --max-concurrent-downloads=%@ --max-connection-per-server=%@ --min-split-size=%@K --split=%@  --max-overall-download-limit=%@K --max-overall-upload-limit=%@K --max-download-limit=%@K --max-upload-limit=%@K --continue=%@ --auto-file-renaming=%@ --allow-overwrite=%@ --disk-cache=%@M --max-tries=%@ --retry-wait=%@ -D ",[[NSBundle mainBundle] pathForResource:@"aria2c" ofType:nil],dir,[[NSBundle mainBundle] pathForResource:@"aria2" ofType:@"conf"],[[NSBundle mainBundle] pathForResource:@"aria2" ofType:@"session"],[[NSBundle mainBundle] pathForResource:@"aria2" ofType:@"session"],[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_MAX_CONCURRENT_DOWNLOADS],[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_MAX_CONNECTION_PER_SERVER],[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_MIN_SPLIT_SIZE],[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_SPLIT],maxDownloadSpeedStr,maxUploadSpeedStr,maxPerDownloadSpeedStr,maxPerUploadSpeedStr,[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_CONTIUNE],[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_AUTO_FILE_RENAMEING_STATE],[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_ALLOW_OVERWRITE_STATE],[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_DISK_CACHE],[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_MAX_TRIES],[[NSUserDefaults standardUserDefaults] objectForKey:Aria2ForMac_RETRY_WAIT]];
    [shCommand writeToFile:startAriaPath atomically:YES encoding:NSUTF8StringEncoding error:nil];

    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:startAriaPath];
    
    [fileHandle seekToEndOfFile];

    if (proxyState == YES && userState == YES)
    {
        NSString *shCommand = [NSString stringWithFormat:@"--%@-proxy='http://%@:%@@%@:%ld'",proxyType,proxyUser,proxyPassword,proxyHost,(long)proxyPort];
        NSData* stringData  = [shCommand dataUsingEncoding:NSUTF8StringEncoding];
        [fileHandle writeData:stringData];
        [fileHandle closeFile];
    }
    
    else
        if(proxyState == YES && userState == NO)
    {
        NSString *shCommand = [NSString stringWithFormat:@"--%@-proxy='http://%@:%ld'",proxyType,proxyHost,(long)proxyPort];
        NSData* stringData  = [shCommand dataUsingEncoding:NSUTF8StringEncoding];
        [fileHandle writeData:stringData];
        [fileHandle closeFile];
    }
    
    else
        if ([[NSUserDefaults standardUserDefaults] boolForKey:Aria2ForMac_LOG_FILE_STATE] == YES)
    {
        NSString *shCommand = [NSString stringWithFormat:@"--log=%@",[[NSBundle mainBundle] pathForResource:@"aria2" ofType:@"log"]];
        NSData* stringData  = [shCommand dataUsingEncoding:NSUTF8StringEncoding];
        [fileHandle writeData:stringData];
        [fileHandle closeFile];
        
    }
    

    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/bin/sh";
    task.arguments = @[startAriaPath];
    [task launch];
}

-(void)closeAria2
{
    NSArray *arg =[NSArray arrayWithObjects:@"aria2c",nil];
    NSTask *task=[[NSTask alloc] init];
    task.launchPath = @"/usr/bin/killall";
    task.arguments = arg;
    [task launch];
    [NSApp terminate:self];

}

- (IBAction)openPreferences:(id)sender
{
    [[AppPrefsWindowsController sharedPrefsWindowController] showWindow:nil];
}

- (IBAction)openIssue:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"https://github.com/muyangren907/Aria2ForMac/issues"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

-(IBAction)checkForUpdate:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"https://github.com/muyangren907/Aria2ForMac/releases"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

@end
