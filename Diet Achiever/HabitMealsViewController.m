//
//  HabitMealsViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "HabitMealsViewController.h"
#import "HabitDailyPlannerViewController.h"

@interface HabitMealsViewController ()

@end

@implementation HabitMealsViewController

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

- (IBAction)onClickDialPlanner:(id)sender {
    
    NSInteger tag = [sender tag];
    NSString *title;
    
    switch (tag) {
        case 1:
            title = @"Breakfast";
            break;
        case 2:
            title = @"Lunch";
            break;
        case 3:
            title = @"Dinner";
            break;
        case 4:
            title = @"Snacks";
            break;
            
        default:
            break;
    }
    
    HabitDailyPlannerViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HabitDailyPlannerViewController"];
    settingVC.dailyPlannerTitle = title;
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

@end
