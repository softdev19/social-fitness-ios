//
//  SettingsViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/23/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onClickLogOut:(id)sender {
    [DIETMANAGER setLoginInfo:1];
    [[NSNotificationCenter defaultCenter] postNotificationName:NAME_NOTIFI_GOTO_LOGIN object:self];
}

@end
