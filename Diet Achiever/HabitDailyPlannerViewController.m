//
//  HabitDailyPlannerViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/25/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "HabitDailyPlannerViewController.h"
#import "HabitDailyPlannerItemAddViewController.h"
#import "PrefixHeader.pch"

@interface HabitDailyPlannerViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img_dailyplanner_fruits;
@property (weak, nonatomic) IBOutlet JWDynamicLabel *lbl_daily_planner_title;

@end

@implementation HabitDailyPlannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //read popup image rendering
    _img_dailyplanner_fruits.image = [_img_dailyplanner_fruits.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_img_dailyplanner_fruits setTintColor:[DIETMANAGER colorWithHexString:@"0X036f3d"]];
    
    _lbl_daily_planner_title.text = self.dailyPlannerTitle.uppercaseString;
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

- (IBAction)onClickEdit:(id)sender {
    [self gotoDetailSelectView];
}
- (IBAction)onClickAdd:(id)sender {
    [self gotoDetailSelectView];
}

- (void) gotoDetailSelectView{
    HabitDailyPlannerItemAddViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HabitDailyPlannerItemAddViewController"];
    settingVC.dailyPlannerTitle = self.dailyPlannerTitle;
    [self.navigationController pushViewController:settingVC animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"DailyPlannerTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIStoryboard *setStory = [UIStoryboard shoppingStoryboard];
//    if(setStory){
//        UIViewController *settingViewController = [setStory instantiateViewControllerWithIdentifier:@"DietMediaDetailViewController"];
//        [self.navigationController pushViewController:settingViewController animated:YES];
//    }
    
}
@end
