//
//  PlanPickerQuizViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/23/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "PlanPickerQuizViewController.h"

@interface PlanPickerQuizViewController ()

@end

@implementation PlanPickerQuizViewController

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

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


@end
