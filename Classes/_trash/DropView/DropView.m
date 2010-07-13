//
//  DropView.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/12.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DropView.h"

//Private
static NSString * const DefaultDirectoryName = @"com.borealkiss.IconUtility";
static NSString * const FileNameIcon = @"Icon.png";

//Private
@interface DropView ()
-(void)_initIvars;
@end

@implementation DropView
@synthesize imageView = _imageView;
@synthesize dragInProgress = _dragInProgress;

-(void)awakeFromNib{
	NSLog(@"%s", __FUNCTION__);
	[self _initIvars];
	[self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, NSTIFFPboardType, nil]];
}

-(void)drawRect:(NSRect)dirtyRect{
	if (_dragInProgress) {
		[[NSColor redColor] set];
		NSFrameRect([self bounds]);
	}
}

-(IBAction)saveButtonPressed:(id)sender{
	NSLog(@"%s", __FUNCTION__);
	[self _filePathWithFileName:FileNameIcon];
}

-(void)dealloc{
	self.imageView = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Private 

-(void)_initIvars{
	self.dragInProgress = NO;
}

-(NSString *)_filePathWithFileName:(NSString *)fileName{
	NSString *pathToDesktop = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) lastObject];
	NSString *destination = [pathToDesktop stringByAppendingPathComponent:DefaultDirectoryName];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:destination] == NO){
		[[NSFileManager defaultManager] createDirectoryAtPath:destination withIntermediateDirectories:NO attributes:nil error:nil];
	}
	
	return [destination stringByAppendingPathComponent:fileName];
}

@end
