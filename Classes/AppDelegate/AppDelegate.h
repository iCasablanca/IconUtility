//
//  AppDelegate.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/12.
//  Copyright boreal-kiss.com 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DraggingView;
@class ViewManager;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet DraggingView *_draggingView;
	ViewManager *_viewManager;
	
	//New
	IBOutlet NSTextField *_messageLabel;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, assign) DraggingView *draggingView;
@property (nonatomic, retain) ViewManager *viewManager;

//New
@property (nonatomic, assign) NSTextField *messageLabel;

-(IBAction)buttonPressed:(id)sender;
@end
