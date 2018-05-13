//
//  HomeViewController.m
//  Diet Achiever
//
//  Created by Wang on 8/23/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "REFrostedViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "DEMONavigationController.h"


@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *dataList;
@property (strong, nonatomic) NSMutableArray *menuList;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*------- Get menu list from data.plist -------*/
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    _dataList = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    _menuList = [NSMutableArray arrayWithArray:[_dataList objectForKey:@"menuList"]];
    
    [self initFrosted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _menuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"MenuTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *menuName = [cell viewWithTag:2];
    UIImageView *img_icon = [cell viewWithTag:1];
    menuName.text = [_menuList[indexPath.row] objectForKey:@"name"];
    img_icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_drawer_%@.png",[_menuList[indexPath.row] objectForKey:@"image"]]];
    img_icon.image = [img_icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img_icon setTintColor:[DIETMANAGER colorWithHexString:@"0X742f00"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *settingViewController;
    UIStoryboard * setStory;

    switch (indexPath.row) {
        case DEF_MENU_HOME:{            
            //settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeScreenViewController"];
            settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DietAchieverDashboardViewController"];
        }
            break;
        case DEF_MENU_COACHING:{
            settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CoachingViewController"];
        }
            break;
        case DEF_MENU_ACCELERATOR:{
            setStory = [UIStoryboard acceleratorStoryboard];
            if(setStory)
            {                
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"BootCampMainViewController"];
            }
        }
            break;
        case DEF_MENU_HABIT:{
             setStory = [UIStoryboard habitStoryboard];
            if(setStory)
            {
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"HabitMainViewController"];
            }
        }
            break;
        case DEF_MENU_PROGRESS:{
            setStory = [UIStoryboard progressStoryboard];
            if(setStory)
            {
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"ProgressMeasurmentViewController"];
            }
        }
            break;
        case DEF_MENU_COMMUNITY:{
            setStory = [UIStoryboard communityStoryboard];
            if(setStory)
            {
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"CommunityMainViewController"];
            }
        }
            break;
        case DEF_MENU_RESCUE:{
            setStory = [UIStoryboard rescueStoryboard];
            if(setStory)
            {
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"RescueMainViewController"];               
            }
        }
            break;
        case DEF_MENU_SHOPPING:{
            setStory = [UIStoryboard shoppingStoryboard];
            if(setStory)
            {
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"ShoppingCenterViewController"];
            }
        }
            break;
        case DEF_MENU_RECIPES:{
            settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RecipesMainViewController"];
        }
            break;
        case DEF_MENU_LIFESTYLE:{
            settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LifeStyleViewController"];
        }
            break;
        case DEF_MENU_EXERCISE:{
             setStory = [UIStoryboard exerciseStoryboard];
            if(setStory)
            {
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"ExerciseZoneMainViewController"];
            }
        }
            break;
        case DEF_MENU_PERSONAL:{
            setStory = [UIStoryboard personalStoryboard];
            if(setStory)
            {
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"PersonalTimerSetupViewController"];
            }
        }
            break;
        case DEF_MENU_EXPERT:{
            setStory = [UIStoryboard expertStoryboard];
            if(setStory)
            {
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"ExpertCornerViewController"];
            }
        }
            break;
        case DEF_MENU_MEMBERSHIP:{
            settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MembershipViewController"];
        }
            break;
        case DEF_MENU_SETTING:{
            setStory = [UIStoryboard userprofileStoryboard];
            if(setStory)
            {
                settingViewController = [setStory instantiateViewControllerWithIdentifier:@"SettingsViewController"];
            }
        }
            break;
     
            
        default:
            break;
    }

    if(settingViewController)
        navigationController.viewControllers = @[settingViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];

}

- (void) initFrosted{
    [self.frostedViewController.view endEditing:YES];
}
@end
