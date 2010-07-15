//
//  ViewManager-SaveImages.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/14.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "ViewManager-SaveImages.h"
#import "DraggingViewProtocol.h"
#import "DraggingImageView.h"
#import "NSBitmapImageRep-Additions.h"

//Private
static NSString * const DefaultDirectoryName	= @"com.borealkiss.IconUtility";

//Private
@interface ViewManager ()
-(NSString *)_filePathWithFileName:(NSString *)fileName;
@end

@implementation ViewManager (SaveImages)

-(BOOL)saveImages{
	for (DraggingImageView *aView in self.childViews){
		if ([aView targetImage] == nil) {
			return NO;
		}
		
		NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithPixelsWide:aView.imageWidth pixelsHigh:aView.imageHeight hasAlpha:YES];
		[imageRep setImage:aView.image];
		NSData *imageData = [imageRep representationUsingType:NSPNGFileType properties:nil];
		[imageData writeToFile:[self _filePathWithFileName:aView.imageName] atomically:YES];
	}
	
	return YES;
}

#pragma mark -
#pragma mark Private 

-(NSString *)_filePathWithFileName:(NSString *)fileName{
	NSString *pathToDesktop = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) lastObject];
	NSString *destination = [pathToDesktop stringByAppendingPathComponent:DefaultDirectoryName];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:destination] == NO){
		[[NSFileManager defaultManager] createDirectoryAtPath:destination withIntermediateDirectories:NO attributes:nil error:nil];
	}
	
	return [destination stringByAppendingPathComponent:fileName];
}

@end
