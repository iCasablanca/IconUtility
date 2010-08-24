//
//  AppDelegate.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/12.
//  Copyright boreal-kiss.com 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWC.h"
 
@implementation AppDelegate
@synthesize window = _window;
@synthesize windowController = _windowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	_windowController = [[MainWC alloc] init];
	[_windowController showWindow:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *) theApplication{
	return YES;
}

-(void)dealloc{
	self.windowController = nil;
	self.window = nil;
	[super dealloc];
}

@end
