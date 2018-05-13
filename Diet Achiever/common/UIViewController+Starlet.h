//
//  UIViewController+Starlet.h
//  Starlet
//
//  Created by khs125 on 10/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Starlet)

- (void)showProgressView;
- (void)hideProgressView;
- (void)showProgressViewWithTitle:(NSString*)title;

- (void)showProgressWithComplete:(void(^)(void))handler;
- (void)showProgressWithLoading:(void(^)(void))handler complete:(void(^)(void))complete;

- (UIBarButtonItem*)rightEndFixedItem;

@end
