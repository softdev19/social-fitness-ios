//
//  HabitExerciseSelectViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/25/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "HabitExerciseSelectViewController.h"

@interface HabitExerciseSelectViewController () <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *timeSelectView;

@property (weak, nonatomic) IBOutlet JWDynamicLabel *circuitTitle;
@property (weak, nonatomic) IBOutlet JWDynamicLabel *circuitSelectSubTitle;
@property (weak, nonatomic) IBOutlet UITextField *txt_add_exe_placeholder;


@property (weak, nonatomic) IBOutlet UIPickerView *pickerHourView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerMinuteView;
@property NSMutableArray *hourArrayData;
@property NSMutableArray *minuteArrayData;


@end

@implementation HabitExerciseSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initialize {
    self.timeSelectView.hidden = YES;

    // Title Setting
    self.circuitTitle.text = _circuitKindTitle;
    self.circuitSelectSubTitle.text = [NSString stringWithFormat:@"SELECT YOUR %@ EXERCISE", _circuitKindTitle.uppercaseString];
    [self.txt_add_exe_placeholder setPlaceholder:[NSString stringWithFormat:@"Add New %@", _circuitKindTitle]];
    
    // picker data array add
    _hourArrayData = [[NSMutableArray alloc] init];
    _minuteArrayData = [[NSMutableArray alloc] init];
    
    for (int i = 60 ; i > 0 ; i --){
        if (i > 24){
            NSString *item = [NSString stringWithFormat:@"%d", i - 1];
            [_minuteArrayData addObject:item];
        }else{
            NSString *item = [NSString stringWithFormat:@"%d", i - 1];
            [_hourArrayData addObject:item];
            [_minuteArrayData addObject:item];
        }
    }
    
    self.pickerHourView.delegate = self;
    self.pickerHourView.dataSource = self;
    self.pickerMinuteView.delegate = self;
    self.pickerMinuteView.dataSource = self;
    
}

- (IBAction)onClickPopViewCancel:(id)sender {
    self.timeSelectView.hidden = YES;
}
- (IBAction)onClickSelectDown:(id)sender {
    self.timeSelectView.hidden = YES;
}

//-------------------------------------------------------------------------------
// Mark: - TableView Delegate     // Use Interface with Shopping Share TableView
//-------------------------------------------------------------------------------

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ExerciseSelectTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *checkImg = [cell viewWithTag:3];
    UILabel *item = [cell viewWithTag:1];
    UILabel *time = [cell viewWithTag:2];
    
    if (indexPath.row != 3){
        item.textColor = [UIColor blackColor];
        time.text = @"";
        checkImg.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.pickerHourView selectRow:22 inComponent:0 animated:NO];
    [self pickerView:self.pickerHourView didSelectRow:22 inComponent:0];
    [self.pickerMinuteView selectRow:29 inComponent:0 animated:NO];
    [self pickerView:self.pickerMinuteView didSelectRow:29 inComponent:0];
    
    self.timeSelectView.hidden = NO;
}


//---------------------------------------------------------------------------------
// Mark:- UipickerView delegate
//---------------------------------------------------------------------------------
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == self.pickerMinuteView){
        return _minuteArrayData.count;
    }else{
        return _hourArrayData.count;
    }
}

// The data to return for the row and component (column) that's being passed in
//- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if(pickerView == self.pickerMinuteView){
//        return _minuteArrayData[row];
//    }else{
//        return _hourArrayData[row];
//    }
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* label = (UILabel*)view;
    if (!label){
        label = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        [label setFont:[UIFont fontWithName:@"Roboto" size:18]];
        [label setTextColor:[DIETMANAGER colorWithHexString:@"f48b45"]];
        label.frame = CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height);
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    // Fill the label text here
    if(pickerView == self.pickerMinuteView){
        label.text = [NSString stringWithFormat:@"%@", _minuteArrayData[row]];
    }else{
        label.text = [NSString stringWithFormat:@"%@", _hourArrayData[row]];
    }
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    UILabel *labelSelected = (UILabel*)[pickerView viewForRow:row forComponent:component];
    [labelSelected setFont:[UIFont fontWithName:@"Roboto" size:18]];
    if(pickerView == self.pickerMinuteView){
        labelSelected.text = [NSString stringWithFormat:@"%@ min", _minuteArrayData[row]];
    }else{
        labelSelected.text = [NSString stringWithFormat:@"%@ hr", _hourArrayData[row]];
    }
}

- (CGFloat) pickerView: (UIPickerView *) pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

@end
