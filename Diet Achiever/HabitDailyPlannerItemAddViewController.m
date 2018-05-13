//
//  HabitDailyPlannerItemAddViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/25/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "HabitDailyPlannerItemAddViewController.h"

@interface HabitDailyPlannerItemAddViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *viewSelectKindOptionA;
@property (weak, nonatomic) IBOutlet UIView *viewSelectKindOptionB;

@property (weak, nonatomic) IBOutlet JWDynamicLabel *lbl_dailyPlannerTitle;
@end

@implementation HabitDailyPlannerItemAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_dailyPlannerTitle.text = _dailyPlannerTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)changeOptionA:(id)sender {
    self.viewSelectKindOptionA.hidden = NO;
    self.viewSelectKindOptionB.hidden = YES;
}
- (IBAction)changeOptionB:(id)sender {
    self.viewSelectKindOptionA.hidden = YES;
    self.viewSelectKindOptionB.hidden = NO;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifierH = @"DailyPlannerSelectHeaderTableCell";
    NSString *cellIdentifier = @"DailyPlannerSelectTableCell";
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0)
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierH];
    else
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}
@end
