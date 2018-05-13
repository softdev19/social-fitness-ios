//
//  DietTabContainerBaseViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/12/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "DietTabContainerBaseViewController.h"

@interface DietTabContainerBaseViewController ()

@end

@implementation DietTabContainerBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialSwapSetUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initialSwapSetUp{
    // override
    self.transitionInProgress = NO;
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.currentViewController = toViewController;
        self.transitionInProgress = NO;
    }];
}

- (void)swapViewControllersForSegueIdentifier:(NSString *)segueIdentifier
{
    //override
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.transitionInProgress||[self.currentSegueIdentifier isEqualToString:segueIdentifier]) {
        return;
    }
    
    self.transitionInProgress = YES;
    self.currentSegueIdentifier = segueIdentifier;
}

@end
