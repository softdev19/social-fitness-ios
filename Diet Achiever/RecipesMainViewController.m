//
//  RecipesMainViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "RecipesMainViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"

@interface RecipesMainViewController ()
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_categories;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_favorites;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_toprated;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_recent;

@property (weak, nonatomic) IBOutlet UIView *recipesDetailView;
@end

@implementation RecipesMainViewController

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

- (IBAction)onClickMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)onClickCategories:(id)sender {
    [self updateIndicator:1];
}
- (IBAction)onClickFavorites:(id)sender {
    [self updateIndicator:2];
    
     [self onClickItem:nil];
}
- (IBAction)onClickTopRated:(id)sender {
    [self updateIndicator:3];
    
     [self onClickItem:nil];
}
- (IBAction)onClickRecent:(id)sender {
    [self updateIndicator:4];
    
    [self onClickItem:nil];
}

- (void) initialize{
    [self updateIndicator:0];
}

- (void) updateIndicator:(NSInteger) tag{
    _tab_indicator_categories.hidden = YES;
    _tab_indicator_favorites.hidden = YES;
    _tab_indicator_toprated.hidden = YES;
    _tab_indicator_recent.hidden = YES;
    
    self.recipesDetailView.hidden = YES;
    
    
    switch (tag) {
        case 0:
            self.recipesDetailView.hidden = NO;
            break;
        case 1:
            _tab_indicator_categories.hidden = NO;
            break;
        case 2:
            _tab_indicator_favorites.hidden = NO;
            break;
        case 3:
            _tab_indicator_toprated.hidden = NO;
            break;
        case 4:
            _tab_indicator_recent.hidden = NO;
            break;
            
        default:
            break;
    }
    
}


- (IBAction)onClickItem:(id)sender {
    UIStoryboard *setStory = [UIStoryboard shoppingStoryboard];
    if(setStory){
        UIViewController *settingViewController = [setStory instantiateViewControllerWithIdentifier:@"DietMediaTableViewController"];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }

}

- (IBAction)onClickMealType:(id)sender{
    UIStoryboard *setStory = [UIStoryboard shoppingStoryboard];
    if(setStory){
        UIViewController *settingViewController = [setStory instantiateViewControllerWithIdentifier:@"DietMediaTableViewController"];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }

}


@end
