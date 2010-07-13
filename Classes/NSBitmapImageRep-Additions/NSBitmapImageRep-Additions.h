//
//  NSBitmapImageRep-Additions.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSBitmapImageRep (Additions)

+(NSBitmapImageRep *)imageRepWithPixelsWide:(NSInteger)width pixelsHigh:(NSInteger)height hasAlpha:(BOOL)alpha;
-(NSImage *)image;
-(void)setImage:(NSImage *)anImage;
@end
