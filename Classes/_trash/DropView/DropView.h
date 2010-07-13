//
//  DropView.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/12.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DropView : NSView {
	IBOutlet NSImageView *_imageView;
	BOOL _dragInProgress;
}
@property (nonatomic, retain) NSImageView *imageView;
@property (nonatomic, assign) BOOL dragInProgress;

@end
