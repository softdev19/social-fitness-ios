//
//  SLCoverView.h
//  SLCoverFlow
//
//  Created by SmartCat on 13-6-19.
//  Copyright (c) 2013年 SmartCat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLCoverView : UIView

// the cover image view
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property UIImageView *coverImage;

- (void) initImageView:(NSString*) url;
@end
