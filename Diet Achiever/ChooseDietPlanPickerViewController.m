//
//  ChooseDietPlanPickerViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/22/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "ChooseDietPlanPickerViewController.h"

@interface ChooseDietPlanPickerViewController ()
//Tab View
@property (weak, nonatomic) IBOutlet UIView *tabPureSelectView;
@property (weak, nonatomic) IBOutlet UIView *tabFlexSelectView;
@property (weak, nonatomic) IBOutlet UIView *tabStartSelectView;
//Choose Plan
@property (weak, nonatomic) IBOutlet UIView *ChoosePurePlanView;
@property (weak, nonatomic) IBOutlet UIView *ChooseFlexPlanView;
@property (weak, nonatomic) IBOutlet UIView *ChooseStarterPlanView;
@property (weak, nonatomic) IBOutlet UIView *alertHelpView;

@end

@implementation ChooseDietPlanPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void) initialize{
    _tabPureSelectView.hidden = YES;
    _tabFlexSelectView.hidden = NO;
    _tabStartSelectView.hidden = NO;
    
    _ChoosePurePlanView.hidden = NO;
    _ChooseFlexPlanView.hidden = YES;
    _ChooseStarterPlanView.hidden = YES;
    _alertHelpView.hidden = YES;
}

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)onClickHelp:(id)sender {
    _alertHelpView.hidden = NO;
}
- (IBAction)onClickHelpNoThanks:(id)sender {
    _alertHelpView.hidden = YES;
}
- (IBAction)onClickHelpYES:(id)sender {
    _alertHelpView.hidden = YES;
    
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PlanPickerQuizViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}


- (IBAction)onClickPure:(id)sender {// Tab Pure
    _tabPureSelectView.hidden = YES;
    _tabFlexSelectView.hidden = NO;
    _tabStartSelectView.hidden = NO;
    
    _ChoosePurePlanView.hidden = NO;
    _ChooseFlexPlanView.hidden = YES;
    _ChooseStarterPlanView.hidden = YES;
}

- (IBAction)onClickFlex:(id)sender {// Tab Flex
    _tabPureSelectView.hidden = NO;
    _tabFlexSelectView.hidden = YES;
    _tabStartSelectView.hidden = NO;
    
    _ChoosePurePlanView.hidden = YES;
    _ChooseFlexPlanView.hidden = NO;
    _ChooseStarterPlanView.hidden = YES;
}

- (IBAction)onClickStarter:(id)sender {// Tab Starter
    _tabPureSelectView.hidden = NO;
    _tabFlexSelectView.hidden = NO;
    _tabStartSelectView.hidden = YES;
    
    _ChoosePurePlanView.hidden = YES;
    _ChooseFlexPlanView.hidden = YES;
    _ChooseStarterPlanView.hidden = NO;
}
@end
