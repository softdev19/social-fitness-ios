//
//  CommunityForumViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/12/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "CommunityForumViewController.h"
#import "CommunitySelfyViewController.h"

@interface CommunityForumViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CommunityForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

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
    
    UIViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForumIntroduceViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}
@end
