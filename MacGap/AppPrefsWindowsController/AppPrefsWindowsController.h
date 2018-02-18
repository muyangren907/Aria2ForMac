#import "DBPrefsWindowController.h"

@interface AppPrefsWindowsController : DBPrefsWindowController <NSWindowDelegate> {
    
    IBOutlet NSView *generalPreferenceView;
    IBOutlet NSView *bandwidthPreferenceView;
    IBOutlet NSView *proxyPreferenceView;
    
}

- (IBAction)update:(id)sender;


@end
