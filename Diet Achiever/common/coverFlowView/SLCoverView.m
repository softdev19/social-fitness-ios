//
//  SLCoverView.m
//  SLCoverFlow
//
//  Created by SmartCat on 13-6-19.
//  Copyright (c) 2013年 SmartCat. All rights reserved.
//

#import "SLCoverView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SLCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:_imageView];
        
        _coverImage = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self addSubview:_coverImage];
    }
    return self;
}

- (void) initImageView:(NSString*) url{
    [self.coverImage setImage:[UIImage imageNamed:url]];
}
@end
