//
//  ViewManager-NSNotification.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "ViewManager-NSNotification.h"
#import "DraggingNotification.h"
#import "DraggingView.h"
#import "IconImageView.h"

@implementation ViewManager (_NSNotification)

-(void)_subscribe{	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(_draggingConcludedHandler:) 
												 name:DraggingConcludedNotification 
											   object:nil];
}

-(void)_unsubscribe{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)_draggingConcludedHandler:(NSNotification *)aNotification{
	DraggingView *aView = (DraggingView *)[aNotification object];
	
	for (IconImageView *childView in self.childViews){
		[childView setTargetImage:[aView targetImage]];
	}
}

@end
