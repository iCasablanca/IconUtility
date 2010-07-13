//
//  ViewManager.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "ViewManager.h"
#import "ViewManager-NSNotification.h"
#import "DraggingViewProtocol.h"
#import "DraggingImageView.h"
#import "NSBitmapImageRep-Additions.h"

//Private
static NSString * const IconsFileName	= @"Icons";
static NSString * const IconsFileType	= @"plist";
static NSString * const IconsNameKey	= @"Name";
static NSString * const IconsSizeKey	= @"Size";
static NSString * const IconsTagKey		= @"Tag";
static NSString * const DefaultDirectoryName = @"com.borealkiss.IconUtility";
 
//Private
@interface ViewManager ()
-(void)_setup;
-(void)_setupChildviews;
-(NSString *)_filePathWithFileName:(NSString *)fileName;
-(void)_didSave;
-(void)_saveDidFail;
@end

@implementation ViewManager
@synthesize parentView = _parentView;
@synthesize childViews = _childViews;
@synthesize icons = _icons;

-(id)initWithParentView:(id <DraggingViewProtocol>)aView{
	if (self = [super init]){
		self.parentView = aView;
		[self _setup];
	}
	return self;
}

-(void)saveImages{
	//NSLog(@"%s", __FUNCTION__);
	
	for (DraggingImageView *aView in self.childViews){
		if ([aView targetImage] == nil) {
			[self performSelector:@selector(_saveDidFail) withObject:nil afterDelay:0.0];
			return;
		}
		
		NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithPixelsWide:aView.imageWidth pixelsHigh:aView.imageHeight hasAlpha:YES];
		[imageRep setImage:aView.image];
		NSData *imageData = [imageRep representationUsingType:NSPNGFileType properties:nil];
		[imageData writeToFile:[self _filePathWithFileName:aView.imageName] atomically:YES];
	}
	
	[self performSelector:@selector(_didSave) withObject:nil afterDelay:0.0];
}

-(void)dealloc{
	[self _unsubscribe];
	
	self.icons = nil;
	self.parentView = nil;
	self.childViews = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Private 

-(void)_setup{
	[self _subscribe];
	[self _setupChildviews];
}

-(void)_setupChildviews{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:IconsFileName ofType:IconsFileType];
	self.icons = [NSArray arrayWithContentsOfFile:filePath];
	
	//Temporal
	NSMutableArray *mutableArray = [[[NSMutableArray alloc] init] autorelease];
	
	for (NSDictionary *dict in self.icons){
		NSString *name = [dict objectForKey:IconsNameKey];
		NSInteger tag = [(NSNumber *)[dict objectForKey:IconsTagKey] integerValue];
		CGFloat size = [(NSNumber *)[dict objectForKey:IconsSizeKey] floatValue];

		DraggingImageView *aView = [(NSView *)self.parentView viewWithTag:tag];
		
		if (aView){
			aView.imageName = name;
			aView.imageWidth = size;
			aView.imageHeight = size;
			[mutableArray addObject:aView];
		}
	}
	
	self.childViews = mutableArray;
}

-(NSString *)_filePathWithFileName:(NSString *)fileName{
	NSString *pathToDesktop = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) lastObject];
	NSString *destination = [pathToDesktop stringByAppendingPathComponent:DefaultDirectoryName];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:destination] == NO){
		[[NSFileManager defaultManager] createDirectoryAtPath:destination withIntermediateDirectories:NO attributes:nil error:nil];
	}
	
	return [destination stringByAppendingPathComponent:fileName];
}

-(void)_didSave{
	NSRunAlertPanel(@"Saved", @"Images successfully saved to the desktop.", @"OK", nil, nil);
}

-(void)_saveDidFail{
	NSRunAlertPanel(@"Error", @"Drag images on the window.", @"OK", nil, nil);
}

@end
