//
//  SignUp1ViewController.m
//  Diet Achiever
//
//  Created by Wang on 8/20/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "SignUp1ViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIViewController+Starlet.h"
#import "UIAlertView+Starlet.h"
#import "JVFloatLabeledTextField.h"
#import "WebService.h"
#import "UserEntity.h"

@interface SignUp1ViewController ()
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *keyAvoidScrollView;
@property (weak, nonatomic) IBOutlet UIView                 *viewTermsAndCondition;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *const_signup1_view_height;
@property (weak, nonatomic) IBOutlet UITextView             *termsTextView;
@property (weak, nonatomic) IBOutlet UIImageView            *termsAgreeCheckImage;

@property (weak, nonatomic) IBOutlet UITextField *txt_firstname;
@property (weak, nonatomic) IBOutlet UITextField *txt_lastname;
@property (weak, nonatomic) IBOutlet UITextField *txt_displayname;
@property (weak, nonatomic) IBOutlet UITextField *txt_email;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;
@property (weak, nonatomic) IBOutlet UITextField *txt_pwdconfirm;

@property UserEntity        *currentUser;
@property BOOL flag_terms;
@end

@implementation SignUp1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) initialize{
    //test code
//    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp3ViewController"];
//    if(vc)
//    {
//        [self.navigationController pushViewController:vc animated:NO];
//    }    
    
    _viewTermsAndCondition.hidden = YES;
    _flag_terms = NO;
    _currentUser = [[UserEntity alloc] init];
    _currentUser = [DIETMANAGER getUserInfo];
        
    if(isiPhone6 || isiPhone6plus){
        _const_signup1_view_height.constant = 400.0;
    }
}
- (IBAction)onClickTermsAndConditions:(id)sender {
    _viewTermsAndCondition.hidden = NO;
}
- (IBAction)onCancelTerms:(id)sender {
    _viewTermsAndCondition.hidden = YES;
}
- (IBAction)onClickAcceptTerms:(id)sender {
    if(_flag_terms){
        [_termsAgreeCheckImage setImage:[UIImage imageNamed:@""]];
        _flag_terms = NO;
    }else{
        [_termsAgreeCheckImage setImage:[UIImage imageNamed:@"ic_signup_step_checked.png"]];
        _flag_terms = YES;
    }
}
- (IBAction)onClickContinue:(id)sender {
    [self validation];
}
- (IBAction)onClickDisplayNameHelp:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Display Name"
                          message:@"This is how your name will be shown to other users."
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil];
    [alert show];
}


- (void) validation{
    NSString *firstName = _txt_firstname.text;
    NSString *lastName = _txt_lastname.text;
    NSString *displayName = _txt_displayname.text;
    NSString *email = _txt_email.text;
    NSString *pwd = _txt_password.text;
    NSString *confirm = _txt_pwdconfirm.text;
    
    if([firstName isEqualToString:@""] ||
       [lastName isEqualToString:@""] ||
       [displayName isEqualToString:@""] ||
       [email isEqualToString:@""] ||
       [pwd isEqualToString:@""] ||
       [confirm isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Diet Achiever Registration"
                              message:@"Please fill the blank fields."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
 
    if(![pwd isEqualToString:confirm]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Diet Achiever Registration"
                              message:@"The two password you provided do not match."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if(!_flag_terms){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Diet Achiever Registration"
                              message:@"You have to agree with our Terms and Conditions before creating the account."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if(![DIETMANAGER NSStringIsValidEmail:email]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Diet Achiever Registration"
                              message:@"Please provide a valid email address"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)email,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"@",
                                                                                                    kCFStringEncodingUTF8 ));
    NSString* param = [NSString stringWithFormat:@"firstName=%@&lastName=%@&displayName=%@&email=%@&password=%@&confirm=%@",
                       firstName,
                       lastName,
                       displayName,
                       encodedString,
                       pwd,
                       confirm];
    [self sendRegistrationInfoToServer: param];
}

- (void) sendRegistrationInfoToServer:(NSString *) param {
    [self showProgressView];
    [WEBSERVICE postRequest:SUB_URL_ACCOUNT_CREATE param:param withSignature:nil withToken:nil success:^(id responseObject) {
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
            if(user && session){
                _currentUser = [[UserEntity alloc] initWithJson:user];
                _currentUser.signature = [session objectForKey:@"signature"];
                _currentUser.token = [session objectForKey:@"token"];
                [DIETMANAGER setUsernfo:_currentUser];
            }
            // Continue
            UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp2ViewController"];
            if(vc)
            {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Registration Failed"
                                  message:[data objectForKey:@"message"]
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
            [alert show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NAME_NOTIFI_GOTO_LOGIN object:self];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}

@end
