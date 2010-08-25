//
//  DraggingView-NSNotification.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "DraggingView-NSNotification.h"

@implementation DraggingView (_NSNotification)

-(void)_postNotificationWithNotificationName:(NSString *)aName{
	NSNotification *aNotification = [NSNotification notificationWithName:aName object:self];
	[[NSNotificationCenter defaultCenter] postNotification:aNotification];
}

@end
