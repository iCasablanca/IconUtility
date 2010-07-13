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
-(void)_initIvars;
@end

@implementation DraggingView
@synthesize highlighted = _highlighted;

-(void)awakeFromNib{
	[self _initIvars];
	[self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, NSTIFFPboardType, nil]];
}

-(void)drawRect:(NSRect)dirtyRect{
	if (_highlighted) {
		[[NSColor blueColor] set];
		NSFrameRect([self bounds]);
	}
}

-(void)dealloc{
	[_targetImage release];
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

-(void)_initIvars{
	self.highlighted = NO;
}

@end
