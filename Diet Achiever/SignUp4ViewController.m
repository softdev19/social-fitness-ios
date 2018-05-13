//
//  SignUp4ViewController.m
//  Diet Achiever
//
//  Created by Wang on 8/22/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "SignUp4ViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIViewController+Starlet.h"
#import "UIView+Utils.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "UserEntity.h"

@interface SignUp4ViewController ()
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView   *keyAvoidScrollView;
@property (weak, nonatomic) IBOutlet UIView                         *inviteHelpView;

@property (weak, nonatomic) IBOutlet UITextField *txt_email1;
@property (weak, nonatomic) IBOutlet UITextField *txt_email2;
@property (weak, nonatomic) IBOutlet UITextField *txt_email3;
@property (weak, nonatomic) IBOutlet UITextField *txt_email4;
@property (weak, nonatomic) IBOutlet UITextField *txt_email5;
@property UserEntity        *currentUser;
@end

@implementation SignUp4ViewController

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
    _inviteHelpView.hidden = YES;
    _currentUser = [DIETMANAGER getUserInfo];
}

- (IBAction)onClickContinue:(id)sender {
    [self validation];
}
- (IBAction)onClickInviteSkipBtn:(id)sender {
    [self skipFriendInvite];
}


- (IBAction)onClickHelp:(id)sender {
    _inviteHelpView.hidden = NO;
}
- (IBAction)onClickCancelHelp:(id)sender {
    _inviteHelpView.hidden = YES;
}

- (void) validation{
    NSString *email1 = _txt_email1.text;
    NSString *email2 = _txt_email2.text;
    NSString *email3 = _txt_email3.text;
    NSString *email4 = _txt_email4.text;
    NSString *email5 = _txt_email5.text;
    
    
    if([email1 isEqualToString:@""] &&
       [email2 isEqualToString:@""] &&
       [email3 isEqualToString:@""] &&
       [email4 isEqualToString:@""] &&
       [email5 isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Diet Achiever Registration"
                              message:@"Please provide at least one email address, or \"Skip\" if you don't want to invite any friends right now."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSString *pparam = [NSString stringWithFormat:@"email1=%@", email1];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&email2=%@", email2]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&email3=%@", email3]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&email4=%@", email4]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&email5=%@", email5]];
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)pparam,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"@",
                                                                                                    kCFStringEncodingUTF8 ));
    [self sendFriendInviteInfoToServer: encodedString];
}

#pragma mark - API Get/Post
- (void) skipFriendInvite{
    [self showProgressView];
    [WEBSERVICE getRequest:SUB_URL_ACCOUNT_INVITE_SKIP param:nil withSignature:_currentUser.signature withToken:_currentUser.token success:^(id responseObject) {
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
            
            UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpDoneViewController"];
            if(vc)
            {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}

- (void) sendFriendInviteInfoToServer:(NSString*) param{
    [self showProgressView];
    [WEBSERVICE postRequest:SUB_URL_ACCOUNT_INVITE param:param withSignature:_currentUser.signature withToken:_currentUser.token success:^(id responseObject) {
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
            
            UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpDoneViewController"];
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
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];

}

@end
