//
//  DietTabContainerBaseViewController.h
//  Diet Achiever
//
//  Created by Wang on 2/12/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "DietABaseViewController.h"

@interface DietTabContainerBaseViewController : DietABaseViewController

@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (assign, nonatomic) BOOL transitionInProgress;
@property (strong, nonatomic) UIViewController *currentViewController;

// Override Methods
- (void)initialSwapSetUp;
- (void)swapViewControllersForSegueIdentifier:(NSString *)segueIdentifier;
- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;
@end
