//
//  ShoppingCenterCategoriesViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/14/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ShoppingCenterGrocerViewController.h"
#import "ShoppingGrocerCategoryViewController.h"
#import "ShoppingGrocerQuicksViewController.h"

@interface ShoppingCenterGrocerViewController ()

@end

@implementation ShoppingCenterGrocerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onClickShakesItem:(id)sender {
    
    NSInteger index = [sender tag];
    NSString *title = @"Shakes";
    
    switch (index) {
        case 1:
            title = @"Shakes";
            break;
        case 2:
            title = @"Stir-frys";
            break;
        case 3:
            title = @"Salads";
            break;
            
        default:
            break;
    }

    ShoppingGrocerQuicksViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingGrocerQuicksViewController"];
    settingViewController.categoryString = title;
    [self.navigationController pushViewController:settingViewController animated:YES];

}

- (IBAction)onClickShopCategory:(id)sender {
    
    NSInteger index = [sender tag];
    NSString *title = @"Veggies";
    
    switch (index) {
        case 1:
            title = @"Veggies";
            break;
        case 2:
            title = @"Fruits";
            break;
        case 3:
            title = @"Protein";
            break;
        case 4:
            title = @"Dairy";
            break;
        case 5:
            title = @"Fats";
            break;
        case 6:
            title = @"Misc";
            break;
            
        default:
            break;
    }
    
    ShoppingGrocerCategoryViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingGrocerCategoryViewController"];
    settingViewController.categoryString = title;
    [self.navigationController pushViewController:settingViewController animated:YES];
}

@end
