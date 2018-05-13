//
//  RescueAdivcerViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/23/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "RescueAdivcerViewController.h"

@interface RescueAdivcerViewController ()

@property (weak, nonatomic) IBOutlet UITextView *txt_advice_descp;
@property (weak, nonatomic) IBOutlet UIImageView *img_advice_photo;
@end

@implementation RescueAdivcerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // *TextView DrawRect from ImageView*
    CGRect dragViewFrame = CGRectMake(_img_advice_photo.frame.origin.x - 5, _img_advice_photo.frame.origin.y - 15, _img_advice_photo.frame.size.width, _img_advice_photo.frame.size.height);
    
    UIBezierPath *exclusion = [UIBezierPath bezierPathWithRect:dragViewFrame];
    
    self.txt_advice_descp.textContainer.exclusionPaths = @[exclusion];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
