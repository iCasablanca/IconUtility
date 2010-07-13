//
//  DraggingImageView-NSDraggingDestination.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DraggingImageView-NSDraggingDestination.h"
#import "DraggingImageView-NSNotification.h"
#import "DraggingNotification.h"

@implementation DraggingImageView (NSDraggingDestination)

- (NSDragOperation)draggingEntered:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	[self _postNotificationWithNotificationName:DraggingEnteredNotification];
	return NSDragOperationCopy;
}

- (void)draggingExited:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	[self _postNotificationWithNotificationName:DraggingExistedNotification];
}

- (BOOL)prepareForDragOperation:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	return YES;
}

- (BOOL)performDragOperation:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	NSPasteboard *pb = [sender draggingPasteboard];
	
	if ([NSImage canInitWithPasteboard:pb]){
		NSImage *anImage = [[[NSImage alloc] initWithPasteboard:pb] autorelease];
		_targetImage = [anImage retain];
		
		return YES;
	}
	
	return NO;
}

- (void)concludeDragOperation:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	[self _postNotificationWithNotificationName:DraggingConcludedNotification];
}

@end
