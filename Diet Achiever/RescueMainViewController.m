//
//  RescueMainViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "RescueMainViewController.h"
#import "REFrostedViewController.h"
#import "RescueTabContainerViewController.h"
#import "AppDelegate.h"

@interface RescueMainViewController ()
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_situation;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_popular;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_article;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_video;

@property (strong, nonatomic) RescueTabContainerViewController *containerView;
@end

@implementation RescueMainViewController

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

- (IBAction)onClickMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)onClickSituation:(id)sender {
    [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_RESCUE_SITUATION];
    [self updateIndicator:1];
}
- (IBAction)onClickPopular:(id)sender {
    UIViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RescueAdivcerViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];

    [self updateIndicator:2];
}
- (IBAction)onClickArticle:(id)sender {
    UIStoryboard *setStory = [UIStoryboard shoppingStoryboard];
    if(setStory){
        UIViewController *settingViewController = [setStory instantiateViewControllerWithIdentifier:@"DietMediaTableViewController"];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }

    
 //  [self updateIndicator:3];
}

- (IBAction)onClickVideos:(id)sender {
    [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_RESCUE_VIDEO];
    [self updateIndicator:4];
}

- (void) initialize{
    [self updateIndicator:4];
}

- (void) updateIndicator:(NSInteger) tag{
    _tab_indicator_situation.hidden = YES;
    _tab_indicator_popular.hidden = YES;
    _tab_indicator_article.hidden = YES;
    _tab_indicator_video.hidden = YES;
    
    switch (tag) {
        case 1:
            _tab_indicator_situation.hidden = NO;
            break;
        case 2:
            _tab_indicator_popular.hidden = NO;
            break;
        case 3:
            _tab_indicator_article.hidden = NO;
            break;
        case 4:
            _tab_indicator_video.hidden = NO;
            break;
            
        default:
            break;
    }
    
}

@end
