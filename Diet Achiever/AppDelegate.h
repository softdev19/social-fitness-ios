//
//  AppDelegate.h
//  Diet Achiever
//
//  Created by Wang on 8/19/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APPDELEGATE     ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


@interface UIStoryboard (AppDelegate)
+ (UIStoryboard*)mainStoryboard;
+ (UIStoryboard*)loginStoryboard;
+ (UIStoryboard*)acceleratorStoryboard;
+ (UIStoryboard*)habitStoryboard;
+ (UIStoryboard*)progressStoryboard;
+ (UIStoryboard*)communityStoryboard;
+ (UIStoryboard*)rescueStoryboard;
+ (UIStoryboard*)shoppingStoryboard;
+ (UIStoryboard*)exerciseStoryboard;
+ (UIStoryboard*)personalStoryboard;
+ (UIStoryboard*)expertStoryboard;
+ (UIStoryboard*)userprofileStoryboard;
@end