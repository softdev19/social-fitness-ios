//
//  HabitWaterViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "HabitWaterViewController.h"

@interface HabitWaterViewController ()

@property (weak, nonatomic) IBOutlet JWDynamicLabel *lbl_percentage;

@property (nonatomic, strong)  IBOutletCollection(UIImageView)  NSArray *imgWaterCups;
@end

@implementation HabitWaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self.navigationController popViewControllerAnimated:NO];
}


- (IBAction)onClickWaterCup:(id)sender {
    
    NSInteger tag = [sender tag];
    UIImageView *imageV = _imgWaterCups[tag - 1];
    [imageV setImage:[UIImage imageNamed:@"ic_wake_intake.png"]];
    float p = tag*100/8;
    //self.lbl_percentage.text = [NSString stringWithFormat:@"%d%%", (int)p];
    
}






@end
