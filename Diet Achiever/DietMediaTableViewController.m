//
//  DietMediaTableViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/17/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "DietMediaTableViewController.h"

@interface DietMediaTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DietMediaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-------------------------------------------------------------------------------
// Mark: - TableView Delegate     // Use Interface with Shopping Share TableView
//-------------------------------------------------------------------------------

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
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
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DietMediaDetailViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}
@end
