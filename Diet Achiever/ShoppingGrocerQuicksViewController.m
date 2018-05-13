//
//  ShoppingGrocerQuicksViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/22/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ShoppingGrocerQuicksViewController.h"

@interface ShoppingGrocerQuicksViewController ()

@property (weak, nonatomic) IBOutlet JWDynamicLabel *categoryTitle;
@property (weak, nonatomic) IBOutlet JWDynamicLabel *categorySubTitle;
@end

@implementation ShoppingGrocerQuicksViewController

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
    
    self.categoryTitle.text = _categoryString;
    self.categorySubTitle.text = [NSString stringWithFormat:@"SELECT YOUR %@", _categoryString.uppercaseString];
}


- (IBAction)onClickShakesItem:(id)sender {
        UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DietMediaTableViewController"];
        [self.navigationController pushViewController:settingViewController animated:YES];
    
}
@end
