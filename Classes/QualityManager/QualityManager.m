//
//  QualityManager.m
//  IconUtility
//
//  Created by boreal-kiss.com on 10/08/24.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import "QualityManager.h"

static id _instance = nil;

//Private
@interface QualityManager ()
+(id)hiddenAlloc;
-(void)_setup;
@end

@implementation QualityManager
@synthesize quality = _quality;

//Override
+(id)alloc{
	NSLog(@"%@: Direct usage of +alloc is not allowded.", [self class]);
	return nil;
}

+(id)sharedInstance{
	if (_instance == nil){
		_instance = [[[[self class] hiddenAlloc] retain] init];
	}
	return _instance;
}

-(id)init{
	if (_instance){
		return _instance;
	}
	
	if (self = [super init]){
		[self _setup];
	}
	return self;
}

#pragma mark -
#pragma mark Private class method

+(id)hiddenAlloc{
	return [[super alloc] autorelease];
}

-(void)_setup{
	_quality = kCGInterpolationDefault;
}

@end
