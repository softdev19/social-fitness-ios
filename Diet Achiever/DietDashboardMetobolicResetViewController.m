//
//  DietDashboardMetobolicResetViewController.m
//  Diet Achiever
//
//  Created by Wang on 10/14/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "DietDashboardMetobolicResetViewController.h"
#import "DEMONavigationController.h"
#import "MediaTableViewCell.h"
#import "REFrostedViewController.h"
#import "UIViewController+Starlet.h"
#import "WebService.h"
#import "MDHTMLLabel.h"

@interface DietDashboardMetobolicResetViewController ()

@end

@implementation DietDashboardMetobolicResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)onClickMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (IBAction)onClickVideoWatch:(id)sender {
}
- (IBAction)onClickArticleRead:(id)sender {
    
}
- (IBAction)onClickDietWorkReadViewClose:(id)sender {
}
- (IBAction)onClickSeeAvaliableChallenge:(id)sender {
}


@end
