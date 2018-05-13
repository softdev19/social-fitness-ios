//
//  DietAchieverDashboardViewController.m
//  Diet Achiever
//
//  Created by Wang on 10/13/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "DietAchieverDashboardViewController.h"
#import "DEMONavigationController.h"
#import "MediaTableViewCell.h"
#import "REFrostedViewController.h"
#import "UIViewController+Starlet.h"
#import "WebService.h"
#import "UIView+Utils.h"
#import "MDHTMLLabel.h"
#import "UserEntity.h"
#import "CountDownEntity.h"
#import "QuoteEntity.h"
#import "BootcampStateEntity.h"

@interface DietAchieverDashboardViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView                    *notifiTableView;
@property (weak, nonatomic) IBOutlet UIView                         *howDoesDietWorkReadView;
@property (weak, nonatomic) IBOutlet UIView                         *metabolicResetView;

@property (weak, nonatomic) IBOutlet UILabel                        *lbl_welcome_message;
@property (weak, nonatomic) IBOutlet UILabel                        *lbl_baddy_msg;
@property (weak, nonatomic) IBOutlet UIImageView                    *baddyProfile;
@property (weak, nonatomic) IBOutlet UILabel                        *lbl_authorName;
@property (weak, nonatomic) IBOutlet UILabel                        *lbl_authorTitle;
@property (weak, nonatomic) IBOutlet UILabel                        *lbl_countdown_day;
@property (weak, nonatomic) IBOutlet UILabel                        *lbl_countdown_hour;

@property (weak, nonatomic) IBOutlet MDHTMLLabel                    *lbl_preparation_day;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint             *const_what_bootcamp_top;  // 7 preparation day: 0
@property (weak, nonatomic) IBOutlet NSLayoutConstraint             *const_how_work_top;       // 7 first diet day : 0

//read popup
@property (weak, nonatomic) IBOutlet UIImageView                    *img_read_heart_png;
@property (weak, nonatomic) IBOutlet UIImageView *img_read_body_png;
@property (weak, nonatomic) IBOutlet UIImageView *img_read_mind_png;

@property UserEntity            *currentUser;
@property CountDownEntity       *countEntity;
@property QuoteEntity           *quoteEntity;
@property BootcampStateEntity   *bootStateEntity;
@property NSString          *welcomeMsg;
@property NSMutableArray    *notiList;
@property int               diet_progress_day;
@end

@implementation DietAchieverDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) initialize{
    _notiList = [[NSMutableArray alloc] init];
    _currentUser = [DIETMANAGER getUserInfo];
    
    _howDoesDietWorkReadView.hidden = YES;
    _metabolicResetView.hidden = YES;
    
    //Test Code
    _diet_progress_day = 12;
    
    if(_diet_progress_day <= DEF_STEP_DIET_PREPARATION_DAY){
        _const_what_bootcamp_top.constant = 0.0;
    }else if(_diet_progress_day > DEF_STEP_DIET_PREPARATION_DAY && _diet_progress_day <= DEF_STEP_DIET_FIRST_SEVEN_DAY){
        _const_how_work_top.constant = 0.0;
        _const_what_bootcamp_top.constant = 135.0;
    }else if(_diet_progress_day > DEF_STEP_DIET_FIRST_SEVEN_DAY && _diet_progress_day <= DEF_STEP_DIET_COMPLETE_DAY){
        _const_how_work_top.constant = 250;
        _const_what_bootcamp_top.constant = 385.0;
    }else if(_diet_progress_day > DEF_STEP_DIET_COMPLETE_DAY && _diet_progress_day <= DEF_STEP_METABOLIC_RESET_COMPLETED_DAY){
        _metabolicResetView.hidden = NO;
    }else{
        UIStoryboard * mainStory = [UIStoryboard mainStoryboard];
        if(mainStory)
        {
            UIViewController * vc = [mainStory instantiateViewControllerWithIdentifier:@"DietDashboardMetobolicResetViewController"];
            if(vc)
            {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    
    //read popup image rendering
    _img_read_heart_png.image = [_img_read_heart_png.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_img_read_heart_png setTintColor:[DIETMANAGER colorWithHexString:@"0Xf48b45"]];
    _img_read_mind_png.image = [_img_read_mind_png.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_img_read_mind_png setTintColor:[DIETMANAGER colorWithHexString:@"0Xf48b45"]];
    _img_read_body_png.image = [_img_read_body_png.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_img_read_body_png setTintColor:[DIETMANAGER colorWithHexString:@"0Xf48b45"]];
    
    [self getBootCampPreparationDataFromServer];
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
- (IBAction)onClickVideoWatch:(id)sender {
}
- (IBAction)onClickArticleRead:(id)sender {
    _howDoesDietWorkReadView.hidden = NO;
}
- (IBAction)onClickDietWorkReadViewClose:(id)sender {
    _howDoesDietWorkReadView.hidden = YES;
}


- (IBAction)gotoBootCamp:(id)sender {
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    UIViewController *settingViewController;
    UIStoryboard * setStory;
    setStory = [UIStoryboard acceleratorStoryboard];
    if(setStory)
    {
        settingViewController = [setStory instantiateViewControllerWithIdentifier:@"AcceleratorMainViewController"];
    }
    if(settingViewController)
        navigationController.viewControllers = @[settingViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _notiList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;

    cellIdentifier = @"NotifiTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *highlight = [cell viewWithTag:2];
    UILabel *title = [cell viewWithTag:3];
    
      
    [cell layoutIfNeeded];
    return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void) updatePreparationInterface{
    _lbl_welcome_message.text = [_welcomeMsg uppercaseString];
    _lbl_countdown_day.text = _countEntity.days;
    _lbl_countdown_hour.text = _countEntity.hours;
    _lbl_preparation_day.htmlText = [NSString stringWithFormat:@"Day <font color=\"#2980b9\">%@</font> of <font color=\"#2980b9\">%@</font>", _bootStateEntity.currentDay, _bootStateEntity.totalDays];
    _lbl_baddy_msg.text = _quoteEntity.message;
    _lbl_authorName.text = _quoteEntity.authorName;
    _lbl_authorTitle.text = _quoteEntity.authorTitle;
    
    [_baddyProfile applyRoundedCornersFull];
    [_baddyProfile sd_setImageWithURL:[NSURL URLWithString:_quoteEntity.avatarUrl] placeholderImage:[UIImage imageNamed:@""]];
  
    [_notifiTableView reloadData];
}


#pragma  Connection API
- (void) getBootCampPreparationDataFromServer{
    [self showProgressView];
    [WEBSERVICE getRequest:SUB_URL_BOOTCAMP_DASHBOARD_PREPARATION param:nil withSignature:_currentUser.signature withToken:_currentUser.token success:^(id responseObject) {
        NSData *objectData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
        NSMutableDictionary *data = [json objectForKey:@"data"];
        NSMutableDictionary *status = [json objectForKey:@"status"];
        NSString *success = [status objectForKey:@"type"];
        
        [self hideProgressView];
        if([success isEqualToString:@"success"]){
            _countEntity =  [[CountDownEntity alloc] initWithJson:[data objectForKey:@"countdown"]];
            _quoteEntity = [[QuoteEntity alloc] initWithJson:[data objectForKey:@"quote"]];
            _bootStateEntity = [[BootcampStateEntity alloc] initWithJson:[data objectForKey:@"state"]];
            _welcomeMsg = [data objectForKey:@"title"];
            
            [self updatePreparationInterface];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"BootCamp Failed"
                                  message:[status objectForKey:@"message"]
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}

@end
