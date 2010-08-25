//
//  DraggingView.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DraggingView.h"

//Private
@interface DraggingView ()
-(void)_setup;
@end

@implementation DraggingView
@synthesize targetImage = _targetImage;
@synthesize highlighted = _highlighted;

-(void)awakeFromNib{
	[self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, NSTIFFPboardType, nil]];
	[self _setup];
}

-(void)drawRect:(NSRect)dirtyRect{
	if (_highlighted) {
		[[NSColor blueColor] set];
		NSFrameRect([self bounds]);
	}
}

-(void)dealloc{
	self.targetImage = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

-(void)setHighlighted:(BOOL)yn{
	_highlighted = yn;
	[self setNeedsDisplay:YES];
}

#pragma mark -
#pragma mark Private 

-(void)_setup{
	self.highlighted = NO;
}

@end
