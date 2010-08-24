//
//  MainWC.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/08/24.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DraggingView;
@class ViewManager;

@interface MainWC : NSWindowController {
	IBOutlet DraggingView *_draggingView;
	IBOutlet NSTextField *_messageLabel;
	ViewManager *_viewManager;
	
	IBOutlet NSPopUpButton *_popUpButton;
	NSArray *_popUpButtonValues;
}
@property (nonatomic, assign) DraggingView *draggingView;
@property (nonatomic, assign) NSTextField *messageLabel;
@property (nonatomic, retain) ViewManager *viewManager;

@property (nonatomic, assign) NSPopUpButton *popUpButton;
@property (nonatomic, retain) NSArray *popUpButtonValues;

+(NSString *)windowNibName;
-(IBAction)buttonPressed:(id)sender;

-(IBAction)popUpButtonValueChanged:(id)sender;
@end
