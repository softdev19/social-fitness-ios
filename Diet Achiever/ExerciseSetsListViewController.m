//
//  ExerciseSetsListViewController.m
//  Diet Achiever
//
//  Created by Wang on 1/29/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ExerciseSetsListViewController.h"

@interface ExerciseSetsListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;

@end

@implementation ExerciseSetsListViewController

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
    NSString *cellIdentifier;
    
    if(tableView == self.tableView1){
        cellIdentifier = @"exerciseSetsCell1";
    }else{
        cellIdentifier = @"exerciseSetsCell2";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIButton *edit = [cell viewWithTag:1];
    JWDynamicLabel *title = [cell viewWithTag:2];
    //UIImageView *img = [cell viewWithTag:3];
    
    [edit addTarget:self.controller action:@selector(showExerciseDatabaseSettingView) forControlEvents:UIControlEventTouchUpInside];
    title.text = [NSString stringWithFormat:@"INT %ld", (long)indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}



@end
