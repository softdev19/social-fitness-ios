//
//  SignUpDoneViewController.m
//  Diet Achiever
//
//  Created by Wang on 10/27/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "SignUpDoneViewController.h"
#import "AppDelegate.h"

@interface SignUpDoneViewController ()

@end

@implementation SignUpDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) initialize{
    [DIETMANAGER setLoginInfo:1];
}

- (IBAction)onClickDone:(id)sender {
    UIStoryboard * mainStory = [UIStoryboard mainStoryboard];
    if(mainStory)
    {
        UIViewController * vc = [mainStory instantiateViewControllerWithIdentifier:@"rootController"];
        if(vc)
        {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }

}

@end
