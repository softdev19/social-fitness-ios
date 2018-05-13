//
//  CoachingViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/1/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "CoachingViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"

@interface CoachingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property  int dataCount;
@end

@implementation CoachingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     _dataCount = 10;
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

- (IBAction)onClickTab:(id)sender {
    
    NSInteger tag = [sender tag];
    
    switch (tag) {
        case 1:
            _dataCount = 3;
            break;
        case 2:
            _dataCount = 4;
            break;
        case 3:
            _dataCount = 3;
            break;
        case 4:
            _dataCount = 5;
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"MediaCoacheTableViewCell";   
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
