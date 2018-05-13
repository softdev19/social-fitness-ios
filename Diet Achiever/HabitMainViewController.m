//
//  HabitMainViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "HabitMainViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"

@interface HabitMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *habitTableView;

@end

@implementation HabitMainViewController

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

- (IBAction)gotoMeal:(id)sender {
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HabitMealsViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}
- (IBAction)gotoExercise:(id)sender {
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HabitExerciseViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}
- (IBAction)gotoWater:(id)sender {
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HabitWaterViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}
- (IBAction)gotoSummary:(id)sender {
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HabitSummaryViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"MediaHabitTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIStoryboard *setStory = [UIStoryboard shoppingStoryboard];
    if(setStory){
        UIViewController *settingViewController = [setStory instantiateViewControllerWithIdentifier:@"DietMediaDetailViewController"];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }

}
@end
