//
//  IconImageView.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/08/25.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 * Image view for icons.
 */
@interface IconImageView : NSImageView {
	CGFloat _imageWidth;
	CGFloat _imageHeight;
	NSImage *_targetImage;
	NSString *_imageName;
}
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSImage *targetImage;

@end
