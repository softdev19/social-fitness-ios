//
//  AppDelegate.m
//  Diet Achiever
//
//  Created by Wang on 8/19/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
@end

static UIStoryboard* mainStoryboard = nil;
static UIStoryboard* loginStoryboard = nil;
static UIStoryboard* acceleratorStoryboard = nil;
static UIStoryboard* habitStoryboard = nil;
static UIStoryboard* progressStoryboard = nil;
static UIStoryboard* communityStoryboard = nil;
static UIStoryboard* rescueStoryboard = nil;
static UIStoryboard* shoppingStoryboard = nil;
static UIStoryboard* exerciseStoryboard = nil;
static UIStoryboard* personalStoryboard = nil;
static UIStoryboard* expertStoryboard = nil;
static UIStoryboard* userprofileStoryboard = nil;

@implementation UIStoryboard (AppDelegate)

+ (UIStoryboard *)mainStoryboard {
    if(mainStoryboard == nil)
        mainStoryboard = [UIStoryboard storyboardWithName:@"MainPart" bundle:nil];
    return mainStoryboard;
}
+ (UIStoryboard*)loginStoryboard{
    if(loginStoryboard == nil)
        loginStoryboard = [UIStoryboard storyboardWithName:@"LoginPart" bundle:nil];
    return loginStoryboard;
}
+ (UIStoryboard*)acceleratorStoryboard{
    if(acceleratorStoryboard == nil)
        acceleratorStoryboard = [UIStoryboard storyboardWithName:@"Accelerator" bundle:nil];
    return acceleratorStoryboard;
}
+ (UIStoryboard*)habitStoryboard{
    if(habitStoryboard == nil)
        habitStoryboard = [UIStoryboard storyboardWithName:@"Habit" bundle:nil];
    return habitStoryboard;
}
+ (UIStoryboard*)progressStoryboard{
    if(progressStoryboard == nil)
        progressStoryboard = [UIStoryboard storyboardWithName:@"Progress" bundle:nil];
    return progressStoryboard;
}
+ (UIStoryboard*)communityStoryboard{
    if(communityStoryboard == nil)
        communityStoryboard = [UIStoryboard storyboardWithName:@"Community" bundle:nil];
    return communityStoryboard;
}
+ (UIStoryboard*)rescueStoryboard{
    if(rescueStoryboard == nil)
        rescueStoryboard = [UIStoryboard storyboardWithName:@"Rescue" bundle:nil];
    return rescueStoryboard;
}
+ (UIStoryboard*)shoppingStoryboard{
    if(shoppingStoryboard == nil)
        shoppingStoryboard = [UIStoryboard storyboardWithName:@"Shopping" bundle:nil];
    return shoppingStoryboard;
}
+ (UIStoryboard*)exerciseStoryboard{
    if(exerciseStoryboard == nil)
        exerciseStoryboard = [UIStoryboard storyboardWithName:@"Exercise" bundle:nil];
    return exerciseStoryboard;
}
+ (UIStoryboard*)personalStoryboard{
    if(personalStoryboard == nil)
        personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    return personalStoryboard;
}
+ (UIStoryboard*)expertStoryboard{
    if(expertStoryboard == nil)
        expertStoryboard = [UIStoryboard storyboardWithName:@"Expert" bundle:nil];
    return expertStoryboard;
}
+ (UIStoryboard*)userprofileStoryboard{
    if(userprofileStoryboard == nil)
        userprofileStoryboard = [UIStoryboard storyboardWithName:@"UserProfile" bundle:nil];
    return userprofileStoryboard;
}
@end
