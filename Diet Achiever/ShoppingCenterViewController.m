//
//  ShoppingCenterViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "ShoppingCenterViewController.h"
#import "REFrostedViewController.h"
#import "ShoppingTabContainerViewController.h"
#import "AppDelegate.h"

@interface ShoppingCenterViewController ()
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_groceries;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_mycart;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_tips;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_mealideas;

@property (weak, nonatomic) IBOutlet ShoppingTabContainerViewController *containerView;
@property (weak, nonatomic) IBOutlet UIView *shoppingTipsCoacheView;

@end

@implementation ShoppingCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"embedcontainer"]) {
        self.containerView=segue.destinationViewController;
    }
}


- (IBAction)onClickGroceries:(id)sender {
    [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_SHOPPING_GROCER];
    [self updateIndicator:1];
}
- (IBAction)onClickMyCart:(id)sender {
    [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_SHOPPING_MYCART];
    [self updateIndicator:2];
}
- (IBAction)onClickTips:(id)sender {
    self.shoppingTipsCoacheView.hidden = false;
    [self updateIndicator:3];
}
- (IBAction)onHideTipCoacheView:(id)sender {
    self.shoppingTipsCoacheView.hidden = true;
}

- (IBAction)onClickMealIdea:(id)sender {
   // [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_SHOPPING_MEALIDEAS];
    UIStoryboard *setStory = [UIStoryboard shoppingStoryboard];
    if(setStory){
        UIViewController *settingViewController = [setStory instantiateViewControllerWithIdentifier:@"DietMediaTableViewController"];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }
    
    [self updateIndicator:4];
}

- (IBAction)onClickCartList:(id)sender {
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingCartListViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}


- (void) initialize{
    self.shoppingTipsCoacheView.hidden = true;
    [self updateIndicator:1];
}

- (void) updateIndicator:(NSInteger) tag{
    _tab_indicator_groceries.hidden = YES;
    _tab_indicator_mycart.hidden = YES;
    _tab_indicator_tips.hidden = YES;
    _tab_indicator_mealideas.hidden = YES;
    
    switch (tag) {
        case 1:
            _tab_indicator_groceries.hidden = NO;
            break;
        case 2:
            _tab_indicator_mycart.hidden = NO;
            break;
        case 3:
            _tab_indicator_tips.hidden = NO;
            break;
        case 4:
            _tab_indicator_mealideas.hidden = NO;
            break;
            
        default:
            break;
    }
    
}
@end
