//
//  SignUp2ViewController.m
//  Diet Achiever
//
//  Created by Wang on 8/21/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "SignUp2ViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIViewController+Starlet.h"
#import "WebService.h"
#import "UserEntity.h"

@interface SignUp2ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView       *keyAvoidScrollView;
@property (weak, nonatomic) IBOutlet UIView                             *viewUnitsType;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray      *btnWeightRadios;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray      *btnHeightRadios;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray   *imgGenderRadios;
@property (weak, nonatomic) IBOutlet UIView                             *birthdaySelectView;
@property (weak, nonatomic) IBOutlet UIView                             *countrySelectView;

@property (weak, nonatomic) IBOutlet UIDatePicker   *birthdayPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView   *countryPickerView;
@property (weak, nonatomic) IBOutlet UITextField    *txt_birthday;
@property (weak, nonatomic) IBOutlet UILabel        *txt_country;
@property (weak, nonatomic) IBOutlet UITextField    *txt_zipcode;
@property (weak, nonatomic) IBOutlet UITextField    *txt_height1;
@property (weak, nonatomic) IBOutlet UITextField    *txt_height2;
@property (weak, nonatomic) IBOutlet UITextField    *txt_weight;
@property (weak, nonatomic) IBOutlet UITextField    *txt_goalweight;

@property (weak, nonatomic) IBOutlet UILabel        *lbl_h_unit1;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_h_unit2;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_w_unit;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_gw_unit;

@property int type_weight_unit;
@property int type_height_unit;
@property int tmp_weight;
@property int tmp_height;
@property int gender;
@property NSString          *selectedCountryId;
@property NSMutableArray    *countryDataArray;
@property NSMutableArray    *countrySource;
@property UserEntity        *currentUser;
@end

@implementation SignUp2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initialize{
    _viewUnitsType.hidden = YES;
    _birthdaySelectView.hidden = YES;
    _countrySelectView.hidden = YES;
    _currentUser = [DIETMANAGER getUserInfo];
    _countryDataArray = [[NSMutableArray alloc] init];
    _countrySource = [[NSMutableArray alloc] init];
    
    [self.birthdayPickerView addTarget:self action:@selector(updateBirthdayFromPicker:) forControlEvents:UIControlEventValueChanged];
    
    //unit Radios
    _type_height_unit = 1;
    _type_weight_unit = 1;
    _gender = 0;
    
    UIButton *weightRadio = _btnWeightRadios[_type_weight_unit];
    UIButton *heightRadio = _btnHeightRadios[_type_height_unit];
    [weightRadio setSelected:YES];
    [heightRadio setSelected:YES];
    
    [self getAccountMetaDataFromServer];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)changeUnitType:(id)sender {
    _viewUnitsType.hidden = NO;
    _tmp_weight = _type_weight_unit;
    _tmp_height = _type_height_unit;
}
- (IBAction)onCloseUnitView:(id)sender {
    _viewUnitsType.hidden = YES;
}
- (IBAction)onClickUnitSaveChanges:(id)sender {
    _type_weight_unit = _tmp_weight;
    _type_height_unit = _tmp_height;

    if(_type_weight_unit == 0){
        _lbl_w_unit.text = @"kg";
        _lbl_gw_unit.text = @"kg";
    }else if(_type_weight_unit == 1){
        _lbl_w_unit.text = @"lbs";
        _lbl_gw_unit.text = @"lbs";
    }else{
        _lbl_w_unit.text = @"stn";
        _lbl_gw_unit.text = @"stn";
    }
    
    if(_type_height_unit == 0){
        _lbl_h_unit1.text = @"m";
        _lbl_h_unit2.text = @"cm";
    }else{
        _lbl_h_unit1.text = @"ft";
        _lbl_h_unit2.text = @"in";
    }
    
    _viewUnitsType.hidden = YES;
}

- (IBAction)onClickRadioWeightBtn:(UIButton *)sender {
    for (NSInteger i = 0 ; i < _btnWeightRadios.count; i ++) {
        UIButton * radio = _btnWeightRadios[i];
        if(sender.tag == i)
        {
            [radio setSelected:YES];
            _tmp_weight = (int)i;
        }else{
            [radio setSelected:NO];
        }
        
    }
}
- (IBAction)onClickRadioHeightBtn:(UIButton *)sender {
    for (NSInteger i = 0 ; i < _btnHeightRadios.count; i ++) {
        UIButton * radio = _btnHeightRadios[i];
        if(sender.tag == i + 3)
        {
            [radio setSelected:YES];
            _tmp_height = (int)i;
        }else{
            [radio setSelected:NO];
        }
        
    }
}
- (IBAction)onClickGenderBtn:(UIButton *)sender {
    UIImageView *male = _imgGenderRadios[0];
    UIImageView *female = _imgGenderRadios[1];
    if(sender.tag == 6){
        [male setImage: [UIImage imageNamed:@"ic_radio_on.png"]];
        [female setImage: [UIImage imageNamed:@"ic_radio_off.png"]];
        _gender = 1;
    }else{
        [male setImage: [UIImage imageNamed:@"ic_radio_off.png"]];
        [female setImage: [UIImage imageNamed:@"ic_radio_on.png"]];
        _gender = 0;
    }
}

- (IBAction)onClickBirthdaySelect:(id)sender {
    _birthdaySelectView.hidden = NO;
}
- (IBAction)onClickCountrySelect:(id)sender {
    _countrySelectView.hidden = NO;
}

- (IBAction)onClickDialogCancel:(id)sender {
    _birthdaySelectView.hidden = YES;
    _countrySelectView.hidden = YES;
}

- (IBAction)onClickDialogSave:(id)sender {
    _birthdaySelectView.hidden = YES;
    _countrySelectView.hidden = YES;
}

- (IBAction)updateBirthdayFromPicker:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, y"];
    _txt_birthday.text = [dateFormatter stringFromDate:self.birthdayPickerView.date];
}
- (IBAction)onClickContinueBtn:(id)sender {
    [self validation];
}

#pragma UIPickerView delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_countryDataArray count];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *retval = (UILabel*)view;
    if (!retval) {
        retval = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    
    retval.font = [UIFont systemFontOfSize:16];
    retval.text = _countryDataArray[row];
    
    return retval;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableDictionary *country = _countrySource[row];
    _selectedCountryId = [NSString stringWithFormat:@"%@",[country objectForKey:@"id"]];
    _txt_country.text = [_countryDataArray objectAtIndex:row];
}

- (void) validation{
    //inch, pound, female
    NSString *unitHeight = @"inch";
    NSString *unitWeight = @"pound";
    NSString *gender = @"female";
    
    if(_gender)
        gender = @"male";
    else
        gender = @"female";
    
    switch (_type_weight_unit) {
        case 0:
            unitWeight = @"kg";
            break;
        case 1:
            unitWeight = @"pound";
            break;
        case 2:
            unitWeight = @"stone";
            break;
        default:
            break;
    }
    
    switch (_type_height_unit) {
        case 0:
            unitHeight = @"cm";
            break;
        case 1:
            unitHeight = @"inch";
            break;
        default:
            break;
    }
    
    NSString *dob = _txt_birthday.text;
    NSString *countryId = _selectedCountryId;
    NSString *zipcode = _txt_zipcode.text;
    NSString *heightBig = _txt_height1.text;
    NSString *heightSmall = _txt_height2.text;
    NSString *weightStart = _txt_weight.text;
    NSString *weightGoal = _txt_goalweight.text;
    
    if([unitWeight isEqualToString:@""] ||
       [unitHeight isEqualToString:@""] ||
       [gender isEqualToString:@""] ||
       [dob isEqualToString:@""] ||
       [countryId isEqualToString:@""] ||
       [heightBig isEqualToString:@""] ||
       [heightSmall isEqualToString:@""] ||
       [weightStart isEqualToString:@""] ||
       [weightGoal isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Diet Achiever Registration"
                              message:@"Please fill the blank fields."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSString *pparam = [NSString stringWithFormat:@"unitHeight=%@", unitHeight];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&unitWeight=%@", unitWeight]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&gender=%@", gender]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&dob=%@", dob]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&countryId=%@", countryId]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&zipcode=%@", zipcode]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&heightBig=%@", heightBig]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&heightSmall=%@", heightSmall]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&weightStart=%@", weightStart]];
    pparam = [pparam stringByAppendingString:[NSString stringWithFormat:@"&weightGoal=%@", weightGoal]];
    
    [self sendAboutInforToServer: pparam];
}

#pragma API GET/POST
- (void) getAccountMetaDataFromServer{
    
    [self showProgressView];
    [WEBSERVICE getRequest:SUB_URL_ACCOUNT_ABOUT_META param:nil withSignature:_currentUser.signature withToken:_currentUser.token success:^(id responseObject) {
        NSData *objectData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
       [self hideProgressView];
        NSMutableDictionary *data = [json objectForKey:@"data"];
        
        if(data != (NSMutableDictionary*)[NSNull null]){
            _countrySource = [data objectForKey:@"countries"];
            for(int i = 0; i < _countrySource.count; i++){
                NSMutableDictionary *item = _countrySource[i];
                [_countryDataArray addObject:[item objectForKey:@"name"]];
            }
            
            [self.countryPickerView reloadAllComponents];
        }else{
            
        }
        
    } failure:^(NSError *error) {
         [self hideProgressView];
    }];
}

- (void) sendAboutInforToServer:(NSString *)param{
    
    [self showProgressView];
    [WEBSERVICE postRequest:SUB_URL_ACCOUNT_ABOUT param:param withSignature:_currentUser.signature withToken:_currentUser.token success:^(id responseObject) {
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
            
            UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp3ViewController"];
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
