//
//  DraggingImageView.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DraggingImageView.h"

@implementation DraggingImageView
@synthesize imageWidth = _imageWidth;
@synthesize imageHeight = _imageHeight;
@synthesize imageName = _imageName;

-(void)awakeFromNib{
	//NSLog(@"%s", __FUNCTION__);
	
	[self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, NSTIFFPboardType, nil]];
}

-(void)dealloc{
	[_targetImage release];
	self.imageName = nil;
	[super dealloc];
}

@end
