//
//  DietUploadStatusViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/26/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "DietUploadStatusViewController.h"
#import "AUIAutoGrowingTextView.h"

@interface DietUploadStatusViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewUploadImageSelect;
@property (weak, nonatomic) IBOutlet UIView *viewUploadPhotoImage4;
@property (weak, nonatomic) IBOutlet UIView *viewUploadPhotoImage2;
@property (weak, nonatomic) IBOutlet UIView *viewUploadPhotoImage1;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomConstrant;
@property (weak, nonatomic) IBOutlet AUIAutoGrowingTextView *txt_inputView;
@end

@implementation DietUploadStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initialize {
    
    [self.txt_inputView becomeFirstResponder];
    self.txt_inputView.maxHeight = 90;
    
    self.viewUploadPhotoImage1.hidden = YES;
    self.viewUploadPhotoImage2.hidden = YES;
    self.viewUploadPhotoImage4.hidden = YES;
    self.viewUploadImageSelect.hidden = YES;
}


- (IBAction)onClickUpload:(id)sender {
}

- (IBAction)onClickPhoto:(id)sender {
    [self.view endEditing:YES];
    self.viewUploadImageSelect.hidden = NO;
}

- (IBAction)onClickImo:(id)sender {
    
}

//---------------------------------
- (IBAction)onClickUploadCancel:(id)sender {
    self.viewUploadImageSelect.hidden = YES;
}
- (IBAction)onClickUpload1:(id)sender {
    self.viewUploadPhotoImage1.hidden = NO;
    self.viewUploadImageSelect.hidden = YES;
}
- (IBAction)onClickUpload2:(id)sender {
    self.viewUploadPhotoImage2.hidden = NO;
    self.viewUploadImageSelect.hidden = YES;
}
- (IBAction)onClickUpload4:(id)sender {
    self.viewUploadPhotoImage4.hidden = NO;
    self.viewUploadImageSelect.hidden = YES;
}

//----------Cancel/upload------------------
- (IBAction)onClickPopupCancel:(id)sender {
    self.viewUploadPhotoImage1.hidden = YES;
    self.viewUploadPhotoImage2.hidden = YES;
    self.viewUploadPhotoImage4.hidden = YES;
    self.viewUploadImageSelect.hidden = YES;
}
- (IBAction)onClickPhotoUpload:(id)sender {
}


//------------------4-----------------------



//-----------------------------------------------------------------------------------------
// Mark: - Keyboard Notification Method
//-----------------------------------------------------------------------------------------
- (void)keyboardWillShow: (NSNotification *) notif{
    NSDictionary* keyboardInfo = [notif userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    self.inputViewBottomConstrant.constant = keyboardFrameBeginRect.size.height;
}

- (void)keyboardWillHide: (NSNotification *) notif{
    self.inputViewBottomConstrant.constant = 0.0;
}


@end
