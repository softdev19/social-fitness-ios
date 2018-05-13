//
//  ExpertAdivcerViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/23/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ExpertAdivcerViewController.h"

@interface ExpertAdivcerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *img_expert_photo;
@property (weak, nonatomic) IBOutlet UITextView *AdivceTextView;

@end

@implementation ExpertAdivcerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // *TextView DrawRect from ImageView*
    CGRect dragViewFrame = CGRectMake(_img_expert_photo.frame.origin.x - 5, _img_expert_photo.frame.origin.y - 15, _img_expert_photo.frame.size.width, _img_expert_photo.frame.size.height);
    //CGRect exclusionRect = [self.view convertRect:dragViewFrame toView:self.AdivceTextView];
    
    UIBezierPath *exclusion = [UIBezierPath bezierPathWithRect:dragViewFrame];
    
    self.AdivceTextView.textContainer.exclusionPaths = @[exclusion];
}

- (void) initialize {
    
    // *TextView DrawRect from ImageView*
    CGRect dragViewFrame = CGRectMake(_img_expert_photo.frame.origin.x -10, _img_expert_photo.frame.origin.y-10, _img_expert_photo.frame.size.width, _img_expert_photo.frame.size.height);
    //CGRect exclusionRect = [self.view convertRect:dragViewFrame toView:self.AdivceTextView];
    
    UIBezierPath *exclusion = [UIBezierPath bezierPathWithRect:dragViewFrame];
    
    self.AdivceTextView.textContainer.exclusionPaths = @[exclusion];

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
