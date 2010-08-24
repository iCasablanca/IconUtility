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
static NSString * const DefaultDirectoryName = @"com.borealkiss.IconUtility";

//Private
@interface ViewManager ()
-(NSString *)_pathToDirectory;
-(NSString *)_untitleDirectoryNameWithIndex:(NSUInteger)index;
@end

@implementation ViewManager (SaveImages)

-(BOOL)saveImages{
	for (DraggingImageView *aView in self.childViews){
		if ([aView targetImage] == nil) {
			return NO;
		}
	}
	
	//Creates a directory for all images.
	NSString *path2Directory = [self _pathToDirectory];
	
	for (DraggingImageView *aView in self.childViews){		
		NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithPixelsWide:aView.imageWidth pixelsHigh:aView.imageHeight hasAlpha:YES];
		[imageRep setImage:aView.image];
		NSData *imageData = [imageRep representationUsingType:NSPNGFileType properties:nil];
		NSString *path2File = [path2Directory stringByAppendingPathComponent:aView.imageName];
		[imageData writeToFile:path2File atomically:NO];
	}
	
	return YES;
}

#pragma mark -
#pragma mark Private 

/**
 * Returns a path to the existing directory that images are saved in.
 */
-(NSString *)_pathToDirectory{
	NSString *path2Desktop = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) lastObject];
	NSString *path2ParentDirectory = [path2Desktop stringByAppendingPathComponent:DefaultDirectoryName];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:path2ParentDirectory] == NO){
		//Creates a parent directory if not existed.
		[[NSFileManager defaultManager] createDirectoryAtPath:path2ParentDirectory withIntermediateDirectories:NO attributes:nil error:nil];
	}
	
	int index = 1;
	NSString *aPath = [path2ParentDirectory stringByAppendingPathComponent:[self _untitleDirectoryNameWithIndex:index]];
	
	while ([[NSFileManager defaultManager] fileExistsAtPath:aPath]) {
		//Changes a search path.
		index++;
		aPath = [path2ParentDirectory stringByAppendingPathComponent:[self _untitleDirectoryNameWithIndex:index]];
	}
	
	//Create a directory.
	[[NSFileManager defaultManager] createDirectoryAtPath:aPath withIntermediateDirectories:NO attributes:nil error:nil];
	
	return aPath;
}

-(NSString *)_untitleDirectoryNameWithIndex:(NSUInteger)index{
	static NSString *Untitle = @"Untitle";
	return [NSString stringWithFormat:@"%@%03d", Untitle, index];;
}

@end
