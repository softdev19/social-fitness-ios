//
//  CircuitBuilderPreviewViewController.m
//  Diet Achiever
//
//  Created by Wang on 1/25/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "CircuitBuilderPreviewViewController.h"

@interface CircuitBuilderPreviewViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CircuitBuilderPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    cellIdentifier = @"CircuitPreviewIntervalTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *intervalTxt = [cell viewWithTag:1];
    intervalTxt.text = [NSString stringWithFormat:@"INTERVAL %ld", (long)indexPath.row];
    
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Test
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ExerciseCircuitTimerViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
