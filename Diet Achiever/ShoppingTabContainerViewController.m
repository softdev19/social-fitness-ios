//
//  ShoppingTabContainerViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/14/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ShoppingTabContainerViewController.h"

#import "ShoppingCenterGrocerViewController.h"
#import "ShoppingCenterMyCartViewController.h"
#import "ShoppingCenterMealIdeasViewController.h"

@interface ShoppingTabContainerViewController ()

@property (strong, nonatomic)  ShoppingCenterGrocerViewController *grocerVController;
@property (strong, nonatomic)  ShoppingCenterMyCartViewController *mycartVController;
@property (strong, nonatomic)  ShoppingCenterMealIdeasViewController *mealideasVController;

@end

@implementation ShoppingTabContainerViewController

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
    if ([segue.identifier isEqualToString:K_SEGUE_SHOPPING_GROCER]) {
        self.grocerVController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:K_SEGUE_SHOPPING_MYCART]) {
        self.mycartVController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:K_SEGUE_SHOPPING_MEALIDEAS]) {
        self.mealideasVController = segue.destinationViewController;
    }
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:K_SEGUE_SHOPPING_GROCER]) {
        // If this is not the first time we're loading this.
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.grocerVController];
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
    else if ([segue.identifier isEqualToString:K_SEGUE_SHOPPING_MYCART]) {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.mycartVController];
    }
    
    else if ([segue.identifier isEqualToString:K_SEGUE_SHOPPING_MEALIDEAS]){
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.mealideasVController];
    }
  
}

- (void) initialSwapSetUp{
    [super initialSwapSetUp];
    
    // Override
    self.currentSegueIdentifier = K_SEGUE_SHOPPING_GROCER;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void)swapViewControllersForSegueIdentifier:(NSString *)segueIdentifier{
    if ([self.currentSegueIdentifier isEqualToString:segueIdentifier])
        return;
    
    [super swapViewControllersForSegueIdentifier: segueIdentifier];
    
    // Override
    if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_SHOPPING_GROCER]) && self.grocerVController) {
        [self swapFromViewController:self.currentViewController toViewController:self.grocerVController];
        return;
    }
    
    else if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_SHOPPING_MYCART]) && self.mycartVController) {
        [self swapFromViewController:self.currentViewController toViewController:self.mycartVController];
        return;
    }
    
    else if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_SHOPPING_MEALIDEAS]) && self.mealideasVController) {
        [self swapFromViewController:self.currentViewController toViewController:self.mealideasVController];
        return;
    }
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}


@end
