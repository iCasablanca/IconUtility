//
//  DraggingImageView.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DraggingViewProtocol.h"

@interface DraggingImageView : NSImageView <DraggingViewProtocol>{
	NSImage *_targetImage;
	
	CGFloat _imageWidth;
	CGFloat _imageHeight;
	NSString *_imageName;
}
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, retain) NSString *imageName;

@end
