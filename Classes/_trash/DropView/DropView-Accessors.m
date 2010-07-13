//
//  DropView-Accessors.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/12.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DropView-Accessors.h"


@implementation DropView (Accessors)

-(void)setDragInProgress:(BOOL)progress{
	_dragInProgress = progress;
	[self setNeedsDisplay:YES];
}

@end
