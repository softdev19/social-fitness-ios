//
//  UIViewController+Starlet.m
//  Starlet
//
//  Created by khs125 on 10/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+Starlet.h"
#import <objc/runtime.h>

#import "MBProgressHUD.h"

#import "UIView+Starlet.h"

#define kProgressViewKey    @"ProgressViewKey"

@interface UIViewController()
@property (strong, nonatomic) UIView * progressView;

@end

@implementation UIViewController (Starlet)

- (UIView*)progressView {
    return objc_getAssociatedObject(self, kProgressViewKey);
}

- (void)setProgressView:(UIView *)aView {
    objc_setAssociatedObject(self, kProgressViewKey, aView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD*)HUD {
    return (MBProgressHUD*)[self.progressView viewWithTag:2014];
}

- (UIView*)addBlurView:(UIView*)view hud:(MBProgressHUD*)hud {
    UIView *snapshotView = [[UIView alloc] initWithFrame:CGRectZero]; //[view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = view.bounds;
    snapshotView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIToolbar *blurView = [[UIToolbar alloc] initWithFrame:CGRectZero];
    blurView.frame = view.bounds;
    blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    blurView.barStyle = UIBarStyleBlack;
    blurView.translucent = YES;

    [snapshotView addSubview:blurView];

    hud.tag = 2014;
    [snapshotView addSubview:hud];
    [snapshotView bringSubviewToFront:hud];

    snapshotView.backgroundColor = [UIColor clearColor];
    snapshotView.hidden = YES;
    
    return snapshotView;
}

- (void)showProgressView {
    [self showProgressViewWithComplete:nil];
}

- (void)showProgressViewWithComplete:(void(^)(void))handler {
    UIViewController* controller = self;
    if (self.tabBarController)
        controller = self.tabBarController;
    else if (self.navigationController)
        controller = self.navigationController;
    
    if (self.progressView == nil) {
        UIView* superView = controller.view;//self.view
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:superView];
        //self.HUD.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        self.progressView = [self addBlurView:superView hud:HUD];

        [superView addSubview:self.progressView];
        [superView bringSubviewToFront:self.progressView];
    }
    
    self.progressView.alpha = 0;
    self.progressView.hidden = NO;
    [UIView animateWithDuration:0.35 animations:^{
        self.progressView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [self.HUD show:YES];
        if (handler)
            handler();
    }];
}

- (void)showProgressViewWithTitle:(NSString*)title {
    [self showProgressView];
    self.HUD.labelText = title;
}

- (void)hideProgressView {
    if (self.progressView) {
        [self.HUD hide:YES];

        [UIView animateWithDuration:0.35 animations:^{
            self.progressView.alpha = 0.f;
        } completion:^(BOOL finished) {
            self.progressView.hidden = YES;
        }];
    }
}

- (void)showProgressWithComplete:(void(^)(void))handler {
    [self showProgressViewWithComplete:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //dispatch_async(dispatch_get_main_queue(), ^{
            handler();
            [self hideProgressView];
        });
    }];
}

- (void)showProgressWithLoading:(void(^)(void))handler complete:(void(^)(void))complete {
    [self showProgressView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        handler();
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressView];
            
            complete();
        });
    });
}

- (UIBarButtonItem*)rightEndFixedItem {
    UIBarButtonItem* endItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    endItem.width = -10;
    endItem.tintColor = [UIColor darkGrayColor];
    return endItem;
}

@end
