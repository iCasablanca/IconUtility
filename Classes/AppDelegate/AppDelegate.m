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
#import <QuartzCore/CoreAnimation.h>

//Private
static NSString * const ImagesDidSaveString = @"Images saved to the desktop.";
static NSString * const CautionString		= @"Drag images on the window.";

//Private
@interface AppDelegate ()
-(void)_setupAnimations;
-(void)_showLabelWithTitle:(NSString *)title textColor:(NSColor *)color;
-(void)_hideLabelAfterDelay:(NSTimeInterval)delay;
-(void)_hideLabel;
-(CABasicAnimation *)_fadeoutAnimation;
@end

@implementation AppDelegate
@synthesize window;
@synthesize viewManager = _viewManager;
@synthesize draggingView = _draggingView;
@synthesize messageLabel = _messageLabel;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	_viewManager = [[ViewManager alloc] initWithParentView:self.draggingView];
	[self _setupAnimations];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *) theApplication{
	return YES;
}

-(IBAction)buttonPressed:(id)sender{
	NSLog(@"%s", __FUNCTION__);
	
	if ([self.viewManager saveImages]){
		[self _showLabelWithTitle:ImagesDidSaveString textColor:[NSColor blueColor]];
		return;
	}
	
	[self _showLabelWithTitle:CautionString textColor:[NSColor redColor]];
}

-(void)dealloc{
	self.viewManager = nil;
	self.draggingView = nil;
	self.messageLabel = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Private 

-(void)_setupAnimations{
	NSDictionary *animationDict = [NSDictionary dictionaryWithObjectsAndKeys:[self _fadeoutAnimation], @"alphaValue", nil];
	[self.messageLabel setAnimations:animationDict];
}

-(void)_showLabelWithTitle:(NSString *)title textColor:(NSColor *)color{
	if (color == nil){
		[self.messageLabel setTextColor:[NSColor blackColor]];
	}
	else{
		[self.messageLabel setTextColor:color];
	}
	
	[self.messageLabel setHidden:NO];
	[self.messageLabel setAlphaValue:0.0];
	[self.messageLabel setTitleWithMnemonic:title];
	[[self.messageLabel animator] setAlphaValue:1.0];
	[self _hideLabelAfterDelay:3.0];
}

-(void)_hideLabelAfterDelay:(NSTimeInterval)delay{
	[self performSelector:@selector(_hideLabel) withObject:nil afterDelay:delay];
}

-(void)_hideLabel{
	[[self.messageLabel animator] setAlphaValue:0.0];
}

-(CABasicAnimation *)_fadeoutAnimation{
	CABasicAnimation *animation = [CABasicAnimation animation];
	animation.duration = 0.5;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	return animation;
}


@end
