//
//  CommunityTabContainerViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/12/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "CommunityTabContainerViewController.h"

#import "CommunityForumViewController.h"
#import "CommunityShareViewController.h"
#import "CommunitySelfyViewController.h"

@interface CommunityTabContainerViewController ()

@property (strong, nonatomic) CommunityShareViewController *shareVController;
@property (strong, nonatomic) CommunitySelfyViewController *selfyVController;
@property (strong, nonatomic) CommunityForumViewController *forumController;
@end

@implementation CommunityTabContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//-----------------------------------------------------------------------------
// Mark: - Swipe view controller Delegate
//-----------------------------------------------------------------------------
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if ([segue.identifier isEqualToString:K_SEGUE_COMMU_SHARE_CONTROLLER]) {
        self.shareVController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:K_SEGUE_COMMU_SELFY_CONTROLLER]) {
        self.selfyVController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:K_SEGUE_COMMU_FORUM_CONTROLLER]) {
        self.forumController = segue.destinationViewController;
    }
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:K_SEGUE_COMMU_FORUM_CONTROLLER]) {
        // If this is not the first time we're loading this.
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.forumController];
        }
        else {
            // If this is the very first time we're loading this we need to do
            // an initial load and not a swap.
            [self addChildViewController:segue.destinationViewController];
            UIView* destView = ((UIViewController *)segue.destinationViewController).view;
            destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:destView];
            [segue.destinationViewController didMoveToParentViewController:self];
        }
    }
    
    // By definition the second view controller will always be swapped with the
    // first one.
    else if ([segue.identifier isEqualToString:K_SEGUE_COMMU_SHARE_CONTROLLER]) {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.shareVController];
    }
    
    else if ([segue.identifier isEqualToString:K_SEGUE_COMMU_SELFY_CONTROLLER]){
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.selfyVController];
    }

}

- (void) initialSwapSetUp{
    [super initialSwapSetUp];
    
    // Override
    self.currentSegueIdentifier = K_SEGUE_COMMU_FORUM_CONTROLLER;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void)swapViewControllersForSegueIdentifier:(NSString *)segueIdentifier{
    if ([self.currentSegueIdentifier isEqualToString:segueIdentifier])
        return;
    
    [super swapViewControllersForSegueIdentifier: segueIdentifier];
    
    // Override
    if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_COMMU_FORUM_CONTROLLER]) && self.forumController) {
        [self swapFromViewController:self.currentViewController toViewController:self.forumController];
        return;
    }
    
    else if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_COMMU_SHARE_CONTROLLER]) && self.shareVController) {
        [self swapFromViewController:self.currentViewController toViewController:self.shareVController];
        return;
    }
    
    else if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_COMMU_SELFY_CONTROLLER]) && self.selfyVController) {
        [self swapFromViewController:self.currentViewController toViewController:self.selfyVController];
        return;
    }
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

@end
