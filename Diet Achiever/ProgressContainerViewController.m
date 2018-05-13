//
//  ProgressContainerViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/10/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "ProgressContainerViewController.h"
#import "ProgressMeasurmentMainViewController.h"
#import "ProgressBioMarkerViewController.h"
#import "ProgressMyImageViewController.h"
#import "ProgressMyGoalsViewController.h"

@interface ProgressContainerViewController ()

@property (strong, nonatomic) ProgressMeasurmentMainViewController *measurementController;
@property (strong, nonatomic) ProgressBioMarkerViewController *biomarkerController;
@property (strong, nonatomic) ProgressMyImageViewController *myimageController;
@property (strong, nonatomic) ProgressMyGoalsViewController *mygoalController;
@end

@implementation ProgressContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialSwapSetUp{
    [super initialSwapSetUp];
    
    self.currentSegueIdentifier = K_SEGUE_PRO_MEASUREMENT_CONTROLLER;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if ([segue.identifier isEqualToString:K_SEGUE_PRO_MEASUREMENT_CONTROLLER]) {
        self.measurementController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:K_SEGUE_PRO_BIOMARKER_CONTROLLER]) {
        self.biomarkerController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:K_SEGUE_PRO_MYIMAGE_CONTROLLER]) {
        self.myimageController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:K_SEGUE_PRO_MYGOAL_CONTROLLER]) {
        self.mygoalController=segue.destinationViewController;
    }
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:K_SEGUE_PRO_MEASUREMENT_CONTROLLER]) {
        // If this is not the first time we're loading this.
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.measurementController];
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
    else if ([segue.identifier isEqualToString:K_SEGUE_PRO_BIOMARKER_CONTROLLER]) {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.biomarkerController];
    }
    
    else if ([segue.identifier isEqualToString:K_SEGUE_PRO_MYIMAGE_CONTROLLER]){
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.myimageController];
    }
    
    else if ([segue.identifier isEqualToString:K_SEGUE_PRO_MYGOAL_CONTROLLER]){
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.mygoalController];
    }
    
}


- (void)swapViewControllersForSegueIdentifier:(NSString *)segueIdentifier
{
    if ([self.currentSegueIdentifier isEqualToString:segueIdentifier])
        return;
    
    [super swapViewControllersForSegueIdentifier: segueIdentifier];
    
    if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_PRO_MEASUREMENT_CONTROLLER]) && self.measurementController) {
        [self swapFromViewController:self.currentViewController toViewController:self.measurementController];
        return;
    }
    
    else if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_PRO_BIOMARKER_CONTROLLER]) && self.biomarkerController) {
        [self swapFromViewController:self.currentViewController toViewController:self.biomarkerController];
        return;
    }
    
    else if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_PRO_MYIMAGE_CONTROLLER]) && self.myimageController) {
        [self swapFromViewController:self.currentViewController toViewController:self.myimageController];
        return;
    }
    
    else if (([self.currentSegueIdentifier isEqualToString:K_SEGUE_PRO_MYGOAL_CONTROLLER]) && self.mygoalController) {
        [self swapFromViewController:self.currentViewController toViewController:self.mygoalController];
        return;
    }
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

@end
