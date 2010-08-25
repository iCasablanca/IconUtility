//
//  MainWC.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/08/24.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <QuartzCore/CoreAnimation.h>
#import "MainWC.h"
#import "ViewManager.h"
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
@synthesize messageLabel = _messageLabel;
@synthesize popUpButton = _popUpButton;
@synthesize popUpButtonValues = _popUpButtonValues;

+(NSString *)windowNibName{
	return @"MainWC";
}

-(id)init{
	return [super initWithWindowNibName:[[self class] windowNibName]];
}

-(void)awakeFromNib{
	_viewManager = [[ViewManager alloc] initWithContentView:[[self window] contentView]];
	[self _setupAnimations];
	[self _createPopUpButtonMenuItems];
}

-(IBAction)saveButtonPressed:(id)sender{
	if ([self.viewManager saveImages:self]){
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
			[[QualityManager sharedInstance] setQuality:kCGInterpolationDefault];
			break;
		case 1:
			[[QualityManager sharedInstance] setQuality:kCGInterpolationNone];
			break;
		case 2:
			[[QualityManager sharedInstance] setQuality:kCGInterpolationLow];
			break;
		case 3:
			[[QualityManager sharedInstance] setQuality:kCGInterpolationMedium];
			break;
		case 4:
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
	self.messageLabel = nil;
	self.popUpButton = nil;
	self.popUpButtonValues = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Private

-(void)_createPopUpButtonMenuItems{
	self.popUpButtonValues = [NSArray arrayWithObjects:@"Default", @"None", @"Low", @"Medium", @"High", nil];
	
	NSMenu *menu = [[[NSMenu alloc] init] autorelease];
	for (NSString *value in _popUpButtonValues){
		NSMenuItem *item = [[[NSMenuItem alloc] init] autorelease];
		[item setTitle:value];
		[menu addItem:item];
	}
	
	[_popUpButton setMenu:menu];
}

//Animation part.
-(void)_setupAnimations{
	NSDictionary *animationDict = [NSDictionary dictionaryWithObjectsAndKeys:[self _fadeoutAnimation], @"alphaValue", nil];
	[self.messageLabel setAnimations:animationDict];
}

//Animation part.
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

//Animation part.
-(void)_hideLabelAfterDelay:(NSTimeInterval)delay{
	[self performSelector:@selector(_hideLabel) withObject:nil afterDelay:delay];
}

//Animation part.
-(void)_hideLabel{
	[[self.messageLabel animator] setAlphaValue:0.0];
}

//Animation part.
-(CABasicAnimation *)_fadeoutAnimation{
	CABasicAnimation *animation = [CABasicAnimation animation];
	animation.duration = 0.5;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	return animation;
}
@end
