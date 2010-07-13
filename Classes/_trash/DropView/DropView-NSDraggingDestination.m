//
//  DropView-NSDraggingDestination.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/12.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DropView-NSDraggingDestination.h"

@implementation DropView (NSDraggingDestination)

- (NSDragOperation)draggingEntered:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	self.dragInProgress = YES;
	return NSDragOperationCopy;
}

- (void)draggingExited:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	self.dragInProgress = NO;
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
		
		
		[self _setImage:anImage];
		//[self _saveImage:anImage];
		//[self.imageView setImage:anImage];
		
		return YES;
	}
	
	return NO;
}

- (void)concludeDragOperation:(id < NSDraggingInfo >) sender{
	//NSLog(@"%s", __FUNCTION__);
	
	self.dragInProgress = NO;
}

#pragma mark -
#pragma mark Private 

-(void)_setImage:(NSImage *)anImage{
	CGImageRef cgImage = [anImage CGImageForProposedRect:NULL context:nil hints:nil];
	NSImage *newImage = [[[NSImage alloc] initWithCGImage:cgImage size:CGSizeMake(114, 114)] autorelease];
	[self.imageView setImage:newImage];
}



@end
