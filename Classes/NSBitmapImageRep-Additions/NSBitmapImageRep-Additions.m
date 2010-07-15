//
//  NSBitmapImageRep-Additions.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "NSBitmapImageRep-Additions.h"

//Private
static const NSInteger DefaultBitsPerSample		= 8;
static const NSInteger DefaultSamplesPerPixel	= 4;
static const NSInteger BitsPerByte				= 8;

@implementation NSBitmapImageRep (Additions)

+(NSBitmapImageRep *)imageRepWithPixelsWide:(NSInteger)width pixelsHigh:(NSInteger)height hasAlpha:(BOOL)alpha{
	/*
	return [[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL 
													pixelsWide:width 
													pixelsHigh:height 
												 bitsPerSample:DefaultBitsPerSample 
											   samplesPerPixel:DefaultSamplesPerPixel 
													  hasAlpha:alpha 
													  isPlanar:NO 
												colorSpaceName:NSCalibratedRGBColorSpace 
												   bytesPerRow:width * (DefaultBitsPerSample * DefaultSamplesPerPixel) / BitsPerByte
												  bitsPerPixel:DefaultBitsPerSample * DefaultSamplesPerPixel] autorelease];
	 */
	
	return [[[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL 
													pixelsWide:width 
													pixelsHigh:height 
												 bitsPerSample:DefaultBitsPerSample 
											   samplesPerPixel:DefaultSamplesPerPixel 
													  hasAlpha:alpha 
													  isPlanar:NO 
												colorSpaceName:NSCalibratedRGBColorSpace 
												   bytesPerRow:0
												  bitsPerPixel:0] autorelease];
}


-(NSImage *)image{
	int w = [self pixelsWide];
	int h = [self pixelsHigh];
	int bpr = [self bytesPerRow];
	int bpp = [self bitsPerPixel];
	int bps = [self bitsPerSample];
	
	CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, [self bitmapData], h * bpr, NULL);
	CGImageRef cgImage = CGImageCreate(w, 
									   h, 
									   bps, 
									   bpp, 
									   bpr, 
									   [[self colorSpace] CGColorSpace], 
									   kCGImageAlphaPremultipliedLast, 
									   dataProvider, 
									   NULL, 
									   YES, 
									   kCGRenderingIntentDefault);

	CGDataProviderRelease(dataProvider);
	NSImage *nsImage = [[[NSImage alloc] initWithCGImage:cgImage size:NSZeroSize] autorelease];
	CGImageRelease(cgImage);
	
	return nsImage;
}


-(void)setImage:(NSImage *)anImage{
	int w = [self pixelsWide];
	int h = [self pixelsHigh];
	int bpr = [self bytesPerRow];
	int bps = [self bitsPerSample];
	
	CGImageRef cgImage = [anImage CGImageForProposedRect:NULL context:nil hints:nil];
	
	CGContextRef context = CGBitmapContextCreate([self bitmapData], 
												 w, 
												 h, 
												 bps, 
												 bpr, 
												 [[self colorSpace] CGColorSpace], 
												 kCGImageAlphaPremultipliedLast);
	
	CGContextDrawImage(context, CGRectMake(0, 0, w, h), cgImage);
	CGContextRelease(context);
}

@end
