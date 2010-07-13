//
//  AppDelegate.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/12.
//  Copyright boreal-kiss.com 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewManager.h"
#import "DraggingView.h"

@implementation AppDelegate
@synthesize window;
@synthesize viewManager = _viewManager;
@synthesize draggingView = _draggingView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	_viewManager = [[ViewManager alloc] initWithParentView:self.draggingView];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *) theApplication{
	return YES;
}

-(IBAction)buttonPressed:(id)sender{
	NSLog(@"%s", __FUNCTION__);
	
	[self.viewManager saveImages];
}

-(void)dealloc{
	self.viewManager = nil;
	self.draggingView = nil;
	[super dealloc];
}

@end
