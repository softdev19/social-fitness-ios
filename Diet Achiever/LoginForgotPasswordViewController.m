//
//  LoginForgotPasswordViewController.m
//  Diet Achiever
//
//  Created by Wang on 10/28/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "LoginForgotPasswordViewController.h"
#import "UIViewController+Starlet.h"
#import "WebService.h"

@interface LoginForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField    *txt_recoveremail;
@property (weak, nonatomic) IBOutlet UIView         *recoverPasswordView;

@end

@implementation LoginForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)onDrawTap:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)onClickRecoverPassword:(id)sender {
    NSString *username = _txt_recoveremail.text;
    if([username isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Forgot Password"
                              message:@"Please fill the blank fields."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    if(![DIETMANAGER NSStringIsValidEmail:username]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Invalid Email"
                              message:@"The email you provided is not valid."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [self sendRecoverEmailInfoToServer:username];
}

- (void) sendRecoverEmailInfoToServer:(NSString*) username{
    [self showProgressView];
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)username,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"@",
                                                                                                    kCFStringEncodingUTF8 ));
    NSString* param = [NSString stringWithFormat:@"email=%@", encodedString];
    
    [WEBSERVICE postRequest:SUB_URL_LOGIN_FORGOT_PWD param:param withSignature:nil withToken:nil success:^(id responseObject) {
        NSData *objectData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
        NSMutableDictionary *data = [json objectForKey:@"data"];
        BOOL success = [[data objectForKey:@"success"] boolValue];
        
        [self hideProgressView];
        if(success){
            self.recoverPasswordView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Success"
                                  message:[data objectForKey:@"message"]
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Password Recovery"
                                  message:[data objectForKey:@"message"]
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
