//
//  DraggingView-NSNotification.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DraggingView.h"

@interface DraggingView (NSNotification)

-(void)_postNotificationWithNotificationName:(NSString *)aName;
@end
