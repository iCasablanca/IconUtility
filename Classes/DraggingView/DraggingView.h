//
//  DraggingView.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 * Drag&Drop detecting view fully convered on the main window's content view.
 */
@interface DraggingView : NSView{
	NSImage *_targetImage;
	BOOL _highlighted;
}
@property (nonatomic, retain) NSImage *targetImage;
@property (nonatomic, assign) BOOL highlighted;

@end
