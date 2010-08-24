//
//  QualityManager.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/08/24.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 * Holds images' quality parameter.
 */
@interface QualityManager : NSObject {
	CGInterpolationQuality _quality;
}

@property (nonatomic, assign) CGInterpolationQuality quality;

+(id)sharedInstance;
@end
