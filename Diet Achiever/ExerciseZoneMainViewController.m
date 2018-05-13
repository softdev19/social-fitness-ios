//
//  ExerciseZoneMainViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/18/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "ExerciseZoneMainViewController.h"
#import "REFrostedViewController.h"
#import "ExerciseZoneDataBaseViewController.h"
#import "AppDelegate.h"

@interface ExerciseZoneMainViewController() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ExerciseZoneMainViewController
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

- (IBAction)onClickAddCircuit:(id)sender {
    UIStoryboard *setStory = [UIStoryboard personalStoryboard];
    if(setStory){
        UIViewController *vc = [setStory instantiateViewControllerWithIdentifier:@"CircuitBuilderViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)onClickItems:(id)sender {
    
    NSString *title;
    switch ([sender tag]) {
        case 1:
            title = @"Full body";
            break;
        case 2:
            title = @"Upper body";
            break;
        case 3:
            title = @"Lower body";
            break;
        case 4:
            title = @"Core";
            break;
            
        default:
            break;
    }
    
    ExerciseZoneDataBaseViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ExerciseZoneDataBaseViewController"];
    vc.exeZoneString = title;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    cellIdentifier = @"ExerciseZoneTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UIStoryboard *setStory = [UIStoryboard personalStoryboard];
    if(setStory){
        UIViewController *vc = [setStory instantiateViewControllerWithIdentifier:@"CircuitBuilderPreviewViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}

@end
