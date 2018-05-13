//
//  ForumIntroduceCommentViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/24/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ForumIntroduceCommentViewController.h"
#import "AppDelegate.h"

@interface ForumIntroduceCommentViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ForumIntroduceCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)onClickUserProfile:(id)sender {
    UIStoryboard *setStoryBoard = [UIStoryboard userprofileStoryboard];
    if(setStoryBoard){
        UIViewController *profileVC = [setStoryBoard instantiateViewControllerWithIdentifier:@"DietAchieverProfileViewController"];
        [self.navigationController pushViewController:profileVC animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"CommunitySelfyTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
