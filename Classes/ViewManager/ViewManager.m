//
//  ViewManager.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "ViewManager.h"
#import "ViewManager-NSNotification.h"
#import "DraggingImageView.h"

//Private
static NSString * const IconsFileName			= @"Icons";
static NSString * const IconsFileType			= @"plist";
static NSString * const IconsNameKey			= @"Name";
static NSString * const IconsSizeKey			= @"Size";
static NSString * const IconsTagKey				= @"Tag";
 
//Private
@interface ViewManager ()
-(void)_setup;
-(void)_setupChildviews;
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

-(void)dealloc{
	[self _unsubscribe];
	self.icons = nil;
	self.parentView = nil;
	self.childViews = nil;
	[super dealloc];
}

//New
-(void)redraw:(id)sender{
	for (id <DraggingViewProtocol> childView in self.childViews){
		[childView setTargetImage:childView.targetImage];
	}
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

@end
