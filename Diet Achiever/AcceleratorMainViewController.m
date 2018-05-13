//
//  AcceleratorMainViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "AcceleratorMainViewController.h"
#import "REFrostedViewController.h"

@interface AcceleratorMainViewController ()

@end

@implementation AcceleratorMainViewController

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

- (IBAction)onClickEnterBootCamp:(id)sender {
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BootCampMainViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

@end
