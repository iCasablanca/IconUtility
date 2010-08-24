//
//  ViewManager.h
//  IconUtility
//
//  Created by boreal-kiss.com on 10/07/13.
//  Copyright 2010 boreal-kiss.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DraggingViewProtocol.h"

@interface ViewManager : NSObject {
	id <DraggingViewProtocol> _parentView;
	
	NSArray *_icons;
	NSArray *_childViews;
}
@property (nonatomic, assign) id <DraggingViewProtocol> parentView;
@property (nonatomic, retain) NSArray *icons;
@property (nonatomic, retain) NSArray *childViews;

-(id)initWithParentView:(id <DraggingViewProtocol>)aView;

//New
-(void)redraw:(id)sender;
@end

#import "ViewManager-SaveImages.h"