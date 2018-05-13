//
//  ExpertCornerViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "ExpertCornerViewController.h"
#import "REFrostedViewController.h"

@interface ExpertCornerViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *expertTableView;

@end

@implementation ExpertCornerViewController

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

- (IBAction)onClickAdivcerTab:(id)sender {
    
    UIViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ExpertAdivcerViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"MediaExpertTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ExpertVideoViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}

@end
