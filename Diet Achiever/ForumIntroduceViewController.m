//
//  ForumIntroduceViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/24/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ForumIntroduceViewController.h"
#import "AppDelegate.h"
#import "DietAchieverProfileViewController.h"

@interface ForumIntroduceViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ForumIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onClickAddPost:(id)sender {
    UIStoryboard *setStoryBoard = [UIStoryboard userprofileStoryboard];
    if(setStoryBoard){
        DietAchieverProfileViewController *settingVC = [setStoryBoard instantiateViewControllerWithIdentifier:@"DietAchieverProfileViewController"];
        settingVC.userType = 1;
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"CommunityTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForumIntroduceCommentViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}
@end
