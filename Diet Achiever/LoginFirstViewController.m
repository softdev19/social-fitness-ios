//
//  LoginFirstViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/7/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "LoginFirstViewController.h"
#import "UIViewController+Starlet.h"
#import "WebService.h"
#import "SLCoverFlowView.h"
#import "SLCoverView.h"
#import "UserEntity.h"

#define M_PI_2      1.57079632679489661923132169163975144   /* pi/2           */
#define M_PI_4      0.785398163397448309615660845819875721  /* pi/4           */
#define M_1_PI      0.318309886183790671537767526745028724  /* 1/pi           */
#define M_2_PI      0.636619772367581343075535053490057448  /* 2/pi           */

@interface LoginFirstViewController ()<SLCoverFlowViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *introScreenView;
@property SLCoverFlowView                   *coverFlowView;
@property (weak, nonatomic) IBOutlet UIView *splashCoverView;

@property (weak, nonatomic) IBOutlet UIImageView *img_intro_indicator1;
@property (weak, nonatomic) IBOutlet UIImageView *img_intro_indicator2;
@property (weak, nonatomic) IBOutlet UIImageView *img_intro_indicator3;
@property (weak, nonatomic) IBOutlet UIImageView *img_intro_indicator4;
@property (weak, nonatomic) IBOutlet UIImageView *img_intro_indicator5;

@property NSMutableArray *imageList;
@property UserEntity        *currentUser;
@end

@implementation LoginFirstViewController

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

- (void) initialize{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(popupUpperViewControllers:) name:NAME_NOTIFI_GOTO_LOGIN object:nil];
    
    _imageList = [[NSMutableArray alloc] init];
    _currentUser = [DIETMANAGER getUserInfo];
    _splashCoverView.hidden = NO;
    
    if(_currentUser && _currentUser.userId){
        [self pingLoginInfoToServer];
    }else
        _splashCoverView.hidden = YES;
    
    CGRect frame = self.introScreenView.bounds;
    
    _coverFlowView = [[SLCoverFlowView alloc] initWithFrame:frame];
    _coverFlowView.backgroundColor = [UIColor clearColor];
    _coverFlowView.delegate = self;
    _coverFlowView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    if(isPhoneWidth320){
        _coverFlowView.coverSize = CGSizeMake(300, 350);
    }else if(isPhoneWidth375){
        _coverFlowView.coverSize = CGSizeMake(355, 415);
    }else{
        _coverFlowView.coverSize = CGSizeMake(380, 440);
    }
    
    _coverFlowView.coverSpace = 20.0;
    _coverFlowView.coverAngle = M_PI_4;
    _coverFlowView.coverScale = 1.0;
    [self.introScreenView addSubview:_coverFlowView];
    
}

-(void)popupUpperViewControllers:(NSNotification*)notification{
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[self class]]){
            [[self navigationController] popToViewController:obj animated:NO];
            _splashCoverView.hidden = YES;
            return;
        }
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    for(int i = 0; i < FTUE_IMAGE_LIST.count ; i ++){
        NSString *imageURL = FTUE_IMAGE_LIST[i];
        if(imageURL)
            [_imageList addObject:imageURL];
    }
    
   [_coverFlowView reloadData];

}

#pragma mark - SLCoverFlowViewDataSource

- (NSInteger)numberOfCovers:(SLCoverFlowView *)coverFlowView {
    return _imageList.count;
}

- (SLCoverView *)coverFlowView:(SLCoverFlowView *)coverFlowView coverViewAtIndex:(NSInteger)index {
    SLCoverView *view;
    if(isPhoneWidth320){
        view = [[SLCoverView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 350)];
        
    }else if(isPhoneWidth375){
        view = [[SLCoverView alloc] initWithFrame:CGRectMake(0.0, 0.0, _introScreenView.frame.size.width - 20, _introScreenView.frame.size.height - 30)];
    }else{
        view = [[SLCoverView alloc] initWithFrame:CGRectMake(0.0, 0.0, 380, 440)];
    }
    [view initImageView:_imageList[index]];
    return view;
}

- (void) indexOfScroll:(NSInteger)index{
    NSLog(@"current index is %ld", (long)index);
    [self updateIntroIndicator:index];
}

- (void) updateIntroIndicator:(NSInteger) scrollint{
    NSInteger index = scrollint + 1;
    
    switch (index) {
        case 1:
            [_img_intro_indicator1 setImage:[UIImage imageNamed:@"ic_intro_home_b"]];
            [_img_intro_indicator2 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator3 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator4 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator5 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            break;
        case 2:
            [_img_intro_indicator1 setImage:[UIImage imageNamed:@"ic_intro_home"]];
            [_img_intro_indicator2 setImage:[UIImage imageNamed:@"ic_dot_blue"]];
            [_img_intro_indicator3 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator4 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator5 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            break;
        case 3:
            [_img_intro_indicator1 setImage:[UIImage imageNamed:@"ic_intro_home"]];
            [_img_intro_indicator2 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator3 setImage:[UIImage imageNamed:@"ic_dot_blue"]];
            [_img_intro_indicator4 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator5 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            break;
        case 4:
            [_img_intro_indicator1 setImage:[UIImage imageNamed:@"ic_intro_home"]];
            [_img_intro_indicator2 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator3 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator4 setImage:[UIImage imageNamed:@"ic_dot_blue"]];
            [_img_intro_indicator5 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            break;
        case 5:
            [_img_intro_indicator1 setImage:[UIImage imageNamed:@"ic_intro_home"]];
            [_img_intro_indicator2 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator3 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator4 setImage:[UIImage imageNamed:@"ic_dot_gray"]];
            [_img_intro_indicator5 setImage:[UIImage imageNamed:@"ic_dot_blue"]];
            break;
            
        default:
            break;
    }
    
}

#pragma Connection API 
- (void) pingLoginInfoToServer{
    [self showProgressView];
    [WEBSERVICE getRequest:SUB_URL_LOGIN_PING param:nil withSignature:_currentUser.signature withToken:_currentUser.token success:^(id responseObject) {
        NSData *objectData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
        NSMutableDictionary *data = [json objectForKey:@"data"];
        BOOL success = [[data objectForKey:@"success"] boolValue];
        
        [self hideProgressView];
        if(success){
            NSMutableDictionary *session = [json objectForKey:@"session"];
            NSMutableDictionary *user = [json objectForKey:@"user"];
            
            _currentUser = [[UserEntity alloc] initWithJson:user];
            _currentUser.signature = [session objectForKey:@"signature"];
            _currentUser.token = [session objectForKey:@"token"];
            [DIETMANAGER setUsernfo:_currentUser];
            int login = [DIETMANAGER isLoginDone];
            
            //Registration Part
            if([_currentUser.status isEqualToString:@"register-about"]){
                UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp2ViewController"];
                if(vc)
                {
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else if([_currentUser.status isEqualToString:@"register-avatar"]){
                UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp3ViewController"];
                if(vc)
                {
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else if([_currentUser.status isEqualToString:@"register-invite"]){
                UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp4ViewController"];
                if(vc)
                {
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else if(login){
                UIStoryboard * antarStory = [UIStoryboard mainStoryboard];
                if(antarStory)
                {
                    UIViewController * vc = [antarStory instantiateViewControllerWithIdentifier:@"rootController"];
                    if(vc)
                    {
                        [self.navigationController pushViewController:vc animated:NO];
                    }
                }
            }
            _splashCoverView.hidden = YES;
        }else{
            NSString *msg = [data objectForKey:@"message"];
            if([msg isEqualToString:@"Session expired."]){
                _currentUser = [[UserEntity alloc] init];
                [DIETMANAGER saveUserInfo:_currentUser];
            }
            
            _splashCoverView.hidden = YES;
        }
        
    } failure:^(NSError *error) {
       [self hideProgressView];
    }];
}

@end
