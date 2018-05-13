//
//  CircuitBuilderViewController.m
//  Diet Achiever
//
//  Created by Wang on 1/24/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "CircuitBuilderViewController.h"
#import "ExerciseDatabaseViewController.h"

@interface CircuitBuilderViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *circuitBuilderSetPickerDilaogView;
@property (weak, nonatomic) IBOutlet UIPickerView *setPickerView;

// Setting Items
@property (weak, nonatomic) IBOutlet UITextField *txt_circuit_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_of_sets;
@property (weak, nonatomic) IBOutlet UITextField *txt_reset_btw_sets;
@property (weak, nonatomic) IBOutlet UITextField *txt_of_intervals;
@property (weak, nonatomic) IBOutlet UITextField *txt_rest_btw_intervals;
@property (weak, nonatomic) IBOutlet UITextField *txt_warm_time;
@property (weak, nonatomic) IBOutlet UITextField *txt_cool_time;

@property NSArray *setDataSource;
@end

@implementation CircuitBuilderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initation{
    self.circuitBuilderSetPickerDilaogView.hidden = YES;
    self.setDataSource = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
}

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//-------------------------------------------------------------
// Mark - picker view control
//-------------------------------------------------------------
- (IBAction)onClickSetDone:(id)sender {
    self.circuitBuilderSetPickerDilaogView.hidden = YES;
}
- (IBAction)onClickSetCancel:(id)sender {
    self.circuitBuilderSetPickerDilaogView.hidden = YES;
}


- (IBAction)onClickPickYourExercise:(id)sender {
//    ExerciseDatabaseViewController* exerciseDatabaseVC = [[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"ExerciseDatabaseViewController"];
//    exerciseDatabaseVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self.navigationController presentViewController:exerciseDatabaseVC animated:NO completion:nil];
    
    UIViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CircuitBuilderNextViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (IBAction)onClickOfSets:(id)sender {
    [self.setPickerView selectRow:5 inComponent:0 animated:YES];
    _circuitBuilderSetPickerDilaogView.hidden = NO;
}

- (IBAction)onClickOfIntervals:(id)sender {
    _circuitBuilderSetPickerDilaogView.hidden = NO;
}

//--------------------------------------------------------------
// Mark - UIPickerView Delegate
//--------------------------------------------------------------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _setDataSource.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _setDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
}

@end
