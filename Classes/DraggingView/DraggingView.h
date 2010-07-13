//
//  DraggingView.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DraggingViewProtocol.h"

@interface DraggingView : NSView <DraggingViewProtocol>{
	BOOL _highlighted;
	NSImage *_targetImage;
}
@property (nonatomic, assign) BOOL highlighted;
@end
