//
//  ProgressMeasurmentViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "ProgressMeasurmentViewController.h"
#import "ProgressContainerViewController.h"
#import "REFrostedViewController.h"

@interface ProgressMeasurmentViewController ()
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_measurement;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_bio;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_myimage;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_mygoal;

@property (strong, nonatomic) ProgressContainerViewController *containerView;

@end

@implementation ProgressMeasurmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigation -

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"embedcontainer"]) {
        self.containerView=segue.destinationViewController;
    }
}

- (IBAction)onClickMeasurment:(id)sender {
    [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_PRO_MEASUREMENT_CONTROLLER];
    [self updateIndicator:1];
}
- (IBAction)onClickBiomarker:(id)sender {
    [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_PRO_BIOMARKER_CONTROLLER];
    [self updateIndicator:2];
}
- (IBAction)onClickMyimage:(id)sender {
    [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_PRO_MYIMAGE_CONTROLLER];
    [self updateIndicator:3];
}
- (IBAction)onClickMyGoal:(id)sender {
    [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_PRO_MYGOAL_CONTROLLER];
    [self updateIndicator:4];
}


- (void) initialize{
    [self updateIndicator:1];
}

- (void) updateIndicator:(NSInteger) tag{
    _tab_indicator_measurement.hidden = YES;
    _tab_indicator_bio.hidden = YES;
    _tab_indicator_myimage.hidden = YES;
    _tab_indicator_mygoal.hidden = YES;
    
    switch (tag) {
        case 1:
            _tab_indicator_measurement.hidden = NO;
            break;
        case 2:
            _tab_indicator_bio.hidden = NO;
            break;
        case 3:
            _tab_indicator_myimage.hidden = NO;
            break;
        case 4:
            _tab_indicator_mygoal.hidden = NO;
            break;
            
        default:
            break;
    }
    
}

@end
