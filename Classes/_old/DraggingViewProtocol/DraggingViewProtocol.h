//
//  DraggingViewProtocol.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DraggingViewProtocol <NSObject>

@optional
-(NSImage *)targetImage;
-(void)setTargetImage:(NSImage *)anImage;
-(void)entered;
-(void)existed;
-(void)concluded;

@end

