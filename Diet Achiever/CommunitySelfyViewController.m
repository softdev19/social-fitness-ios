//
//  CommunitySelfyViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/12/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "CommunitySelfyViewController.h"
#import "AppDelegate.h"

@interface CommunitySelfyViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CommunitySelfyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) onClickPostSelfie:(id)sender {
    
    UIStoryboard *setStoryBoard = [UIStoryboard userprofileStoryboard];
    if(setStoryBoard){
        UIViewController *settingVC = [setStoryBoard instantiateViewControllerWithIdentifier:@"DietUploadStatusViewController"];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"CommunitySelfyTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIButton *profileBtn = [cell viewWithTag:11];
    if(profileBtn){
        [profileBtn addTarget:self action:@selector(showUserProfileVC) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void) showUserProfileVC {
    UIStoryboard *setStoryBoard = [UIStoryboard userprofileStoryboard];
    if(setStoryBoard){
        UIViewController *profileVC = [setStoryBoard instantiateViewControllerWithIdentifier:@"DietAchieverProfileViewController"];
        [self.navigationController pushViewController:profileVC animated:YES];
    }
}
@end
