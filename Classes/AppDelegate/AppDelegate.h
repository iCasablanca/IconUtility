//
//  AppDelegate.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/12.
//  Copyright boreal-kiss.com 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *_window;
	NSWindowController *_windowController;
}
@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) NSWindowController *windowController;

@end
