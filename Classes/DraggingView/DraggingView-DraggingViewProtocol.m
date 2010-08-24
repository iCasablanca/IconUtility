//
//  DraggingView-DraggingViewProtocol.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DraggingView-DraggingViewProtocol.h"


@implementation DraggingView (DraggingViewProtocol)

-(NSImage *)targetImage{
	return _targetImage;
}

-(void)entered{
	//NSLog(@"%s", __FUNCTION__);
	
	self.highlighted = YES;
} 

-(void)existed{
	//NSLog(@"%s", __FUNCTION__);
	
	self.highlighted = NO;
}

-(void)concluded{
	//NSLog(@"%s", __FUNCTION__);
	
	self.highlighted = NO;
}

@end
