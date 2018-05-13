//
//  SignUp3ViewController.m
//  Diet Achiever
//
//  Created by Wang on 8/22/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "SignUp3ViewController.h"
#import "UIViewController+Starlet.h"
#import "UIView+Utils.h"
#import "WebService.h"
#import "UserEntity.h"

@interface SignUp3ViewController () <UIPickerViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView    *imgProfileAvatar;
@property UserEntity        *currentUser;
@end

@implementation SignUp3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void) viewDidAppear:(BOOL)animated{
    [_imgProfileAvatar applyRoundedCornersFull];
}
- (void) initialize{
    _currentUser = [DIETMANAGER getUserInfo];
}

- (IBAction)onClickCameraBtn:(id)sender {
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:Nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Take Photo", nil) ,NSLocalizedString(@"Select Image", nil) , nil];
    action.tag=10001;
    [action showInView:self.view];
}


- (IBAction)onClickUploadAvatar:(id)sender {
    [self uploadAvatarInfoToServer];
}
- (IBAction)onClickSkipAvatar:(id)sender {
    [self skipAvatarUpload];
}
#pragma mark - API Get/Post
- (void) skipAvatarUpload{
    [self showProgressView];
    [WEBSERVICE getRequest:SUB_URL_ACCOUNT_AVATAR_SKIP param:nil withSignature:_currentUser.signature withToken:_currentUser.token success:^(id responseObject) {
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
            
            UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp4ViewController"];
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

- (void) uploadAvatarInfoToServer{
    NSData *imageData = UIImageJPEGRepresentation(self.imgProfileAvatar.image, 0.5f);
    
    [self showProgressView];
    [WEBSERVICE postImageRequest:SUB_URL_ACCOUNT_AVATAR_UPLOAD fieldName:@"avatar" imageData:imageData withSignature:_currentUser.signature withToken:_currentUser.token success:^(id responseObject) {
        NSData *objectData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
        [self hideProgressView];
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
            
            UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp4ViewController"];
            if(vc)
            {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            
        }

    }failure:^(NSError *error) {
        [self hideProgressView];
    }];
}

#pragma mark - UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self openCamera];
            break;
        case 1:
            [self chooseFromLibaray];
            break;
        case 2:
            break;
        case 3:
            break;
    }
}

-(void)openCamera
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing=YES;
        imagePickerController.view.tag = 102;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
    else
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"CAM_NOT_AVAILABLE", nil)delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alt show];
    }
}

-(void)chooseFromLibaray
{
    // Set up the image picker controller and add it to the view
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing=YES;
    imagePickerController.view.tag = 102;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:^{
    }];
}

#pragma mark -
#pragma mark - UIImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _imgProfileAvatar.contentMode = UIViewContentModeScaleAspectFill;
    _imgProfileAvatar.clipsToBounds = YES;
    _imgProfileAvatar.image=[info objectForKey:UIImagePickerControllerEditedImage];
    // isProPicAdded=YES;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
