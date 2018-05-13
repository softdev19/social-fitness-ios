//
//  HabitExerciseViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/5/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "HabitExerciseViewController.h"
#import "HabitExerciseSelectViewController.h"

@interface HabitExerciseViewController ()

@end

@implementation HabitExerciseViewController

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
    [self.navigationController popViewControllerAnimated:NO];
}


- (IBAction)onClickExerciseCircuit:(id)sender {
    
    NSInteger index = [sender tag];
    NSString *title = @"Cardio";
    
    switch (index) {
        case 1:
            title = @"Cardio";
            break;
        case 2:
            title = @"Strength";
            break;
        case 3:
            title = @"Restorative";
            break;
            
        default:
            break;
    }
    
    HabitExerciseSelectViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HabitExerciseSelectViewController"];
    settingVC.circuitKindTitle = title;
    [self.navigationController pushViewController:settingVC animated:YES];
}

@end
