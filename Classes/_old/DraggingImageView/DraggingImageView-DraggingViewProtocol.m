//
//  DraggingImageView-DraggingViewProtocol.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DraggingImageView-DraggingViewProtocol.h"

//New
#import "NSBitmapImageRep-Additions.h"
#import "QualityManager.h"

//Private
@interface DraggingImageView ()
-(void)_resizeImage:(NSImage *)anImage;
@end

@implementation DraggingImageView (DraggingViewProtocol)

-(NSImage *)targetImage{
	return _targetImage;
}

-(void)setTargetImage:(NSImage *)anImage{
	//NSLog(@"%s", __FUNCTION__);
	
	if (_targetImage != anImage){
		[_targetImage release];
		_targetImage = [anImage retain];
	}
	
	[self _resizeImage:_targetImage];
}

-(void)entered{
	//NSLog(@"%s", __FUNCTION__);
} 

-(void)existed{
	//NSLog(@"%s", __FUNCTION__);
}

-(void)concluded{
	//NSLog(@"%s", __FUNCTION__);
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

/*
-(void)_resizeImage:(NSImage *)anImage{
	CGImageRef cgImage = [anImage CGImageForProposedRect:NULL context:nil hints:nil];
	NSImage *newImage = [[[NSImage alloc] initWithCGImage:cgImage size:NSMakeSize(_imageWidth, _imageHeight)] autorelease];
	
	//ImageView's image.
	[self setImage:newImage];
}
 */

@end
