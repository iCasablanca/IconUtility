//
//  DraggingView-NSDraggingDestination.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DraggingView-NSDraggingDestination.h"
#import "DraggingView-NSNotification.h"
#import "DraggingNotification.h"

@implementation DraggingView (NSDraggingDestination)

- (NSDragOperation)draggingEntered:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	self.highlighted = YES;
	return NSDragOperationCopy;
}

- (void)draggingExited:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	self.highlighted = NO;
}

- (BOOL)prepareForDragOperation:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	return YES;
}

- (BOOL)performDragOperation:(id < NSDraggingInfo >) sender{
	NSLog(@"%s", __FUNCTION__);
	
	NSPasteboard *pb = [sender draggingPasteboard];
	
	if ([NSImage canInitWithPasteboard:pb]){
		NSImage *anImage = [[[NSImage alloc] initWithPasteboard:pb] autorelease];
		_targetImage = [anImage retain];
		return YES;
	}
	
	return NO;
}

- (void)concludeDragOperation:(id < NSDraggingInfo >) sender{
	NSLog(@"%s", __FUNCTION__);
	
	[self _postNotificationWithNotificationName:DraggingConcludedNotification];
	self.highlighted = NO;
}

@end
