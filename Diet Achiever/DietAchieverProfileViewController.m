//
//  DietAchieverProfileViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/25/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "DietAchieverProfileViewController.h"

@interface DietAchieverProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *ConstraintUserTypeSelfOrOther;
@property (weak, nonatomic) IBOutlet UIView               *ViewUserTypeSelf;
@end

@implementation DietAchieverProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initialize {
    
    if(_userType == 1){
        self.ConstraintUserTypeSelfOrOther.constant = 120;
    }else{
        self.ViewUserTypeSelf.hidden = YES;
        self.ConstraintUserTypeSelfOrOther.constant = 80;
    }
}


- (IBAction) onClickUpdateStatus:(id)sender {
    
    UIViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DietUploadStatusViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}


//------------------------------------------------------------------------------
// Mark - Table view data source
//------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ProfilePostTableViewCell";
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
