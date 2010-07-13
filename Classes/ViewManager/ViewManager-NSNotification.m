//
//  ViewManager-NSNotification.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "ViewManager-NSNotification.h"
#import "DraggingNotification.h"
#import "DraggingViewProtocol.h"

@implementation ViewManager (NSNotification)

-(void)_subscribe{
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(_draggingEnteredHandler:) 
												 name:DraggingEnteredNotification 
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(_draggingExistedHandler:) 
												 name:DraggingExistedNotification 
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(_draggingConcludedHandler:) 
												 name:DraggingConcludedNotification 
											   object:nil];
}

-(void)_unsubscribe{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)_draggingEnteredHandler:(NSNotification *)aNotification{
	//NSLog(@"%s", __FUNCTION__);
	
	if ([aNotification object] == self.parentView){
		return;
	}
	
	[self.parentView entered];
}

-(void)_draggingExistedHandler:(NSNotification *)aNotification{
	//NSLog(@"%s", __FUNCTION__);
	
	if ([aNotification object] == self.parentView){
		return;
	}
	
	[self.parentView existed];
}

-(void)_draggingConcludedHandler:(NSNotification *)aNotification{
	//NSLog(@"%s", __FUNCTION__);
	
	id <DraggingViewProtocol> obj = [aNotification object];
	
	for (id <DraggingViewProtocol> childView in self.childViews){
		[childView setTargetImage:[obj targetImage]];
	}
	
	[self.parentView concluded];
	
	[self _hideAndShow];
}

-(void)_hideAndShow{
	static const NSInteger HideTag = 301;
	static const NSInteger ShowTag = 401;
	
	for (NSView *aView in [(NSView *)self.parentView subviews]){
		if ([aView tag] == HideTag){
			[aView setHidden:YES];
		}
		
		if ([aView tag] == ShowTag){
			[aView setHidden:NO];
		}
	}
}

@end
