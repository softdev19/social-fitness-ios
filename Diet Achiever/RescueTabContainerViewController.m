//
//  RescueTabContainerViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/23/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "RescueTabContainerViewController.h"
#import "RescueSituationsViewController.h"
#import "RescueVideosViewController.h"

@interface RescueTabContainerViewController ()

@property (strong, nonatomic) RescueVideosViewController        *videoController;
@property (strong, nonatomic) RescueSituationsViewController    *situationController;
@end

@implementation RescueTabContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-----------------------------------------------------------------------------
// Mark: - Swipe view controller Delegate
//-----------------------------------------------------------------------------
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if ([segue.identifier isEqualToString:K_SEGUE_RESCUE_VIDEO]) {
        self.videoController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:K_SEGUE_RESCUE_SITUATION]) {
        self.situationController = segue.destinationViewController;
    }
    
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:K_SEGUE_RESCUE_VIDEO]) {
        // If this is not the first time we're loading this.
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.videoController];
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
    else if ([segue.identifier isEqualToString:K_SEGUE_RESCUE_SITUATION]) {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.situationController];
    }
    
}

- (void) initialSwapSetUp{
    [super initialSwapSetUp];
    
    // Override
    self.currentSegueIdentifier = K_SEGUE_RESCUE_VIDEO;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void)swapViewControllersForSegueIdentifier:(NSString *)segueIdentifier{
    if ([self.currentSegueIdentifier isEqualToString:segueIdentifier])
        return;
    
    [super swapViewControllersForSegueIdentifier: segueIdentifier];
    
    // Override
    if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_RESCUE_VIDEO]) && self.videoController) {
       [self swapFromViewController:self.currentViewController toViewController:self.videoController];
        return;
    }
    
    else if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_RESCUE_SITUATION]) && self.situationController) {
        [self swapFromViewController:self.currentViewController toViewController:self.situationController];
        return;
    }
    
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

@end
