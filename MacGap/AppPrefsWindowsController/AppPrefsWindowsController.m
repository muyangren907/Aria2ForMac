#import "AppPrefsWindowsController.h"


@implementation AppPrefsWindowsController


-(void)setupToolbar {
    [self addView:generalPreferenceView label:NSLocalizedStringFromTable(@"General1",@"Preferences",nil) image:[NSImage imageNamed:@"General"]];
    [self addView:bandwidthPreferenceView label:NSLocalizedStringFromTable(@"Web1",@"Preferences",nil) image:[NSImage imageNamed:@"Bandwidth"]];
    [self addView:proxyPreferenceView label:NSLocalizedStringFromTable(@"proxy1",@"Preferences",nil) image:[NSImage imageNamed:@"Proxy"]];
    
    [self setCrossFade:YES];
	[self setShiftSlowsAnimation:YES];
    [[NSColorPanel sharedColorPanel] setShowsAlpha:YES];
    [NSColor setIgnoresAlpha:NO];
}

-(IBAction)selectSavePath:(id)sender
{
    NSPopUpButton *popupButton = (NSPopUpButton *)sender;
    if ([popupButton indexOfSelectedItem] == 2) {
        NSOpenPanel *panel = [NSOpenPanel openPanel];
        [panel setCanChooseFiles:NO];
        [panel setCanChooseDirectories:YES];
        [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
            if (result == NSFileHandlingPanelOKButton) {
                NSURL *url = panel.directoryURL;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:[url path] forKey:Aria2ForMac_SAVE_PATH];
                [[popupButton itemAtIndex:0] setTitle:[[url path] lastPathComponent]];
                [[popupButton itemAtIndex:0] setImage:[[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericFolderIcon)]];
                [defaults setObject:[[url path] lastPathComponent] forKey:Aria2ForMac_SAVE_PATH_DISPLAY];
                
                [defaults synchronize];
            }
        }];
        
        [popupButton selectItemAtIndex:0];
    }
}

- (IBAction)editAria2ForMacConf:(id)sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aria2" ofType:@"conf"];
    if ([fileManager fileExistsAtPath:path])
    {
        [[NSWorkspace sharedWorkspace] openFile:path withApplication:@"TextEdit"];
    }
    else
    {
        NSAlert *alertDefult = [[NSAlert alloc]init];
        [alertDefult setMessageText:@"miss the conf file"];
        [alertDefult setInformativeText:@"miss the conf file"];
        [alertDefult addButtonWithTitle:@"ok!"];
    }
}

- (IBAction)logFileState:(NSButton *)sender
{
     if (sender.state == NSOffState)
     {
         [[NSUserDefaults standardUserDefaults] setBool:NO  forKey:Aria2ForMac_LOG_FILE_STATE];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
     }
     else
         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Aria2ForMac_LOG_FILE_STATE];
         [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

- (void)relaunchAfterDelay:(float)seconds
{
    NSTask *task = [[NSTask alloc] init] ;
    NSMutableArray *args = [NSMutableArray array];
    [args addObject:@"-c"];
    [args addObject:[NSString stringWithFormat:@"sleep %f; open \"%@\"", seconds, [[NSBundle mainBundle] bundlePath]]];
    [task setLaunchPath:@"/bin/sh"];
    [task setArguments:args];
    [task launch];
    [NSApp terminate:nil];
}

- (IBAction)restartAria2:(id)sender
{
    NSString *restartAriaPath = [[NSBundle mainBundle] pathForResource:@"restartAria2" ofType:@"sh"];
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/bin/sh";
    task.arguments = @[restartAriaPath];
    [task launch];
    [self relaunchAfterDelay:1.0];
}

- (IBAction)update:(id)sender {
    NSPopUpButton *popupButton = (NSPopUpButton *)sender;
    NSString *label = [popupButton titleOfSelectedItem];
    [[NSUserDefaults standardUserDefaults] setObject:label forKey:Aria2ForMac_PROXY_TYPE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (IBAction)continueState:(NSButton *)sender {
    if (sender.state == NSOffState)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:Aria2ForMac_CONTIUNE];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    else
        [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:Aria2ForMac_CONTIUNE];
        [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)autoFileRenamingState:(NSButton *)sender {
    if (sender.state == NSOffState)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:Aria2ForMac_AUTO_FILE_RENAMEING_STATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else
        [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:Aria2ForMac_AUTO_FILE_RENAMEING_STATE];
         [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)allowOverwriteState:(NSButton *)sender {
    if (sender.state == NSOffState)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:Aria2ForMac_ALLOW_OVERWRITE_STATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
        [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:Aria2ForMac_ALLOW_OVERWRITE_STATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
