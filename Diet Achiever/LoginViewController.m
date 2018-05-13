//
//  LoginViewController.m
//  Diet Achiever
//
//  Created by Wang on 8/20/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "LoginViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "AppDelegate.h"
#import "DGActivityIndicatorView.h"
#import "UIViewController+Starlet.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "WebService.h"
#import "UserEntity.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *keyAvoidScrollView;
@property (weak, nonatomic) IBOutlet UIView         *loginButtonView;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_log_in;
@property (weak, nonatomic) IBOutlet UITextField    *txt_username;
@property (weak, nonatomic) IBOutlet UITextField    *txt_password;

@property (weak, nonatomic) IBOutlet UIImageView  *logoImageView;
@property (weak, nonatomic) IBOutlet UIView      *typingView;
@property BOOL keyboardShow;

@property UserEntity        *currentUser;
@end

@implementation LoginViewController

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
    [nc addObserver:self selector:@selector(loginPopupUpperViewControllers:) name:NAME_NOTIFI_GOTO_LOGIN_TYPE object:nil];
    
    _currentUser = [[UserEntity alloc] init];
    self.txt_username.delegate = self;
    self.txt_password.delegate = self;
}

- (IBAction)onClickLogin:(id)sender {   
    NSString *username = _txt_username.text;
    NSString *password = _txt_password.text;
    
    if([username isEqualToString:@""] || [password isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Diet Achiever Login"
                              message:@"Please fill the blank fields."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if(![DIETMANAGER NSStringIsValidEmail:username]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Diet Achiever Login"
                              message:@"Please provide a valid email address"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    //login
    [self sendLoginInfoToServer:username withPassword:password];
}

-(void)loginPopupUpperViewControllers:(NSNotification*)notification{
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[self class]]){
            [[self navigationController] popToViewController:obj animated:NO];
            return;
        }
    }
}

- (IBAction)onClickFBLogin:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    //[login setLoginBehavior:(FBSDKLoginBehaviorWeb)]; //FB dialoge show
    [login logInWithReadPermissions: @[@"email", @"public_profile"]
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    
                                    NSLog(@"Cancelled");
                                } else {
                                    NSLog(@"Logged in %@", result);//HTTPMethod: @"GET"
                                    
                                    if([FBSDKAccessToken currentAccessToken]) {
                                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil ] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                            if (!error) {
                                                NSLog(@"Success facebook result: %@ , %@", result, [FBSDKAccessToken currentAccessToken].tokenString);
                                                NSString *token = [FBSDKAccessToken currentAccessToken].tokenString;
                                                [self sendFBLoginInfoToServer:token];
                                            }
                                            
                                        }];
                                    }
                                }
                            }];

}


- (IBAction)onDrawTap:(id)sender {
    [self.view endEditing:YES];
}


#pragma Connection API
- (void) sendLoginInfoToServer:(NSString*) username withPassword:(NSString*) password{
    //Animation
//    _lbl_log_in.text = @"";
//    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)[@(DGActivityIndicatorAnimationTypeBallSpinFadeLoader) integerValue] tintColor:[UIColor whiteColor]];
//    CGFloat width = 5.0f;
//    CGFloat height = 5.0f;
//    
//    activityIndicatorView.frame = CGRectMake(self.loginButtonView.frame.size.width/2 - 2.5f, self.loginButtonView.frame.size.height/2 - 2.5f, width, height);
//    [self.loginButtonView addSubview:activityIndicatorView];
////   [activityIndicatorView startAnimating];

    [self showProgressView];
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)username,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"@",
                                                                                                    kCFStringEncodingUTF8 ));
    NSString* param = [NSString stringWithFormat:@"email=%@&password=%@", encodedString, password];

    [WEBSERVICE postRequest:SUB_URL_LOGIN_CLASSIC param:param withSignature:nil withToken:nil success:^(id responseObject) {
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
            [DIETMANAGER saveUserInfo:_currentUser];
            [DIETMANAGER setLoginInfo:1];
            
            // Goto Dashboard
            UIStoryboard * antarStory = [UIStoryboard mainStoryboard];
            if(antarStory)
            {
                UIViewController * vc = [antarStory instantiateViewControllerWithIdentifier:@"rootController"];
                if(vc)
                {
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        //[activityIndicatorView stopAnimating];
    }];    
}

- (void) sendFBLoginInfoToServer: (NSString*) token{
    [self showProgressView];
    NSString* param = [NSString stringWithFormat:@"token=%@", token];
    [WEBSERVICE postRequest:SUB_URL_LOGIN_FACEBOOK param:param withSignature:nil withToken:nil success:^(id responseObject) {
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
            [DIETMANAGER setLoginInfo:1];
            
            // Goto Dashboard
            UIStoryboard * antarStory = [UIStoryboard mainStoryboard];
            if(antarStory)
            {
                UIViewController * vc = [antarStory instantiateViewControllerWithIdentifier:@"rootController"];
                if(vc)
                {
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
        
    } failure:^(NSError *error) {
       [self hideProgressView];
    }];
}

//------------------------------------------------------------
// Mark: keyboard appear process
//------------------------------------------------------------

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    if(!_keyboardShow){
        [self.logoImageView setFrame:CGRectMake(self.logoImageView.frame.origin.x + 30, self.logoImageView.frame.origin.y + 30, self.logoImageView.frame.size.width - 60, self.logoImageView.frame.size.width - 60)];
        [self.typingView setFrame:CGRectMake(self.typingView.frame.origin.x, self.typingView.frame.origin.y - 40, self.typingView.frame.size.width, self.typingView.frame.size.width)];

        _keyboardShow = true;
    }
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    if(_keyboardShow){
        [self.logoImageView setFrame:CGRectMake(self.logoImageView.frame.origin.x - 30, self.logoImageView.frame.origin.y - 30, self.logoImageView.frame.size.width + 60, self.logoImageView.frame.size.width + 60)];
        [self.typingView setFrame:CGRectMake(self.typingView.frame.origin.x, self.typingView.frame.origin.y + 40, self.typingView.frame.size.width, self.typingView.frame.size.width)];
        
        _keyboardShow = false;
    }
    
}
@end
