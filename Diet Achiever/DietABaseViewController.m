//
//  DietABaseViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/5/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "DietABaseViewController.h"
#import "REFrostedViewController.h"

@interface DietABaseViewController ()

@end

@implementation DietABaseViewController

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

- (IBAction)onTapHideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)onTapBackVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onTapDismissVC:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

// Click Menu
- (IBAction)onClickMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

@end
