//
//  IconImageView.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/08/25.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "IconImageView.h"
#import "NSBitmapImageRep-Additions.h"
#import "QualityManager.h"

//Private
@interface IconImageView ()
-(void)_resizeImage:(NSImage *)anImage;
@end

@implementation IconImageView
@synthesize imageWidth = _imageWidth;
@synthesize imageHeight = _imageHeight;
@synthesize imageName = _imageName;
@synthesize targetImage = _targetImage;

-(void)dealloc{
	self.targetImage = nil;
	self.imageName = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

-(void)setTargetImage:(NSImage *)anImage{
	if (_targetImage != anImage){
		[_targetImage release];
		_targetImage = [anImage retain];
	}
	
	[self _resizeImage:_targetImage];
}

#pragma mark -
#pragma mark Private 

-(void)_resizeImage:(NSImage *)anImage{
	NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithPixelsWide:_imageWidth pixelsHigh:_imageHeight hasAlpha:YES];
	[imageRep setImage:anImage interpolationQuality:[[QualityManager sharedInstance] quality]];
	NSData *imageData = [imageRep representationUsingType:NSPNGFileType properties:nil];
	NSImage *newImage = [[[NSImage alloc] initWithData:imageData] autorelease];
	[self setImage:newImage];
}

@end
