//
//  ViewManager.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 * Manages icon image views and the saving function.
 */
@interface ViewManager : NSObject {
	NSView *_contentView;
	NSArray *_icons;
	NSArray *_childViews;
}
@property (nonatomic, retain) NSView *contentView;
@property (nonatomic, retain) NSArray *icons;
@property (nonatomic, retain) NSArray *childViews;

-(id)initWithContentView:(NSView *)aView;
-(void)redraw:(id)sender;
@end

#import "ViewManager-SaveImages.h"