//
//  MainWC.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/08/24.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "MainWC.h"
#import "ViewManager.h"
#import "DraggingView.h"
#import <QuartzCore/CoreAnimation.h>

#import "QualityManager.h"

//Private
static NSString * const ImagesDidSaveString = @"Images saved to the desktop.";
static NSString * const CautionString		= @"Drag images on the window.";

//Private
@interface MainWC ()
-(void)_createPopUpButtonMenuItems;
-(void)_setupAnimations;
-(void)_showLabelWithTitle:(NSString *)title textColor:(NSColor *)color;
-(void)_hideLabelAfterDelay:(NSTimeInterval)delay;
-(void)_hideLabel;
-(CABasicAnimation *)_fadeoutAnimation;
@end

@implementation MainWC
@synthesize viewManager = _viewManager;
@synthesize draggingView = _draggingView;
@synthesize messageLabel = _messageLabel;
@synthesize popUpButton = _popUpButton;
@synthesize popUpButtonValues = _popUpButtonValues;

+(NSString *)windowNibName{
	return @"MainWC";
}

-(id)init{
	return [super initWithWindowNibName:[[self class] windowNibName]];
}

-(void)windowDidLoad{
	_viewManager = [[ViewManager alloc] initWithParentView:self.draggingView];
	[self _setupAnimations];
	[self _createPopUpButtonMenuItems];
}

-(IBAction)buttonPressed:(id)sender{
	//NSLog(@"%s", __FUNCTION__);
	
	if ([self.viewManager saveImages]){
		[self _showLabelWithTitle:ImagesDidSaveString textColor:[NSColor blueColor]];
		return;
	}
	
	[self _showLabelWithTitle:CautionString textColor:[NSColor redColor]];
}

-(IBAction)popUpButtonValueChanged:(id)sender{
	//NSLog(@"%s", __FUNCTION__);
	
	NSPopUpButtonCell *aCell = (NSPopUpButtonCell *)sender;
	NSMenuItem *anItem = [aCell selectedItem];
	NSInteger index = [aCell indexOfItem:anItem];
	
	switch (index) {
		case 0:
			//NSLog(@"Default");
			[[QualityManager sharedInstance] setQuality:kCGInterpolationDefault];
			break;
		case 1:
			//NSLog(@"None");
			[[QualityManager sharedInstance] setQuality:kCGInterpolationNone];
			break;
		case 2:
			//NSLog(@"Low");
			[[QualityManager sharedInstance] setQuality:kCGInterpolationLow];
			break;
		case 3:
			//NSLog(@"Medium");
			[[QualityManager sharedInstance] setQuality:kCGInterpolationMedium];
			break;
		case 4:
			//NSLog(@"High");
			[[QualityManager sharedInstance] setQuality:kCGInterpolationHigh];
			break;	
		default:
			break;
	}
	
	//Redraw
	[_viewManager redraw:self];
}

-(void)dealloc{
	self.viewManager = nil;
	self.draggingView = nil;
	self.messageLabel = nil;
	self.popUpButton = nil;
	self.popUpButtonValues = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Private

-(void)_createPopUpButtonMenuItems{
	//NSLog(@"%s", __FUNCTION__);
	
	self.popUpButtonValues = [NSArray arrayWithObjects:@"Default", @"None", @"Low", @"Medium", @"High", nil];
	
	NSMenu *menu = [[[NSMenu alloc] init] autorelease];
	for (NSString *value in _popUpButtonValues){
		NSMenuItem *item = [[[NSMenuItem alloc] init] autorelease];
		[item setTitle:value];
		[menu addItem:item];
	}
	
	[_popUpButton setMenu:menu];
}

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
