//
//  AcceleratorCalendarViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/25/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "AcceleratorCalendarViewController.h"
#import "FAQTableViewCell.h"

@interface AcceleratorCalendarViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *dietFAQView;

@property NSInteger faqCellSelectedIndex;
@property (nonatomic, strong) NSMutableArray *faqArray;
@property (nonatomic, strong) NSMutableArray *indexPaths;
@end

@implementation AcceleratorCalendarViewController

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
    self.dietFAQView.hidden = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 45.0;
    
    _faqCellSelectedIndex = -1;
    [self setupArray];
}

- (void)setupArray
{
    self.faqArray = FAQ_Q_LIST.mutableCopy;
}

- (IBAction)onClickHelpBtn:(id)sender {
    self.dietFAQView.hidden = NO;
}
- (IBAction)onClickFAQcancel:(id)sender {
    self.dietFAQView.hidden = YES;
    _faqCellSelectedIndex = -1;
}

- (void) faqQuestionSelected:(NSIndexPath*)indexPath {
    
    NSInteger row = indexPath.row;
    if(_faqCellSelectedIndex == row){
        
        [self retractArray];
    }else{
        _faqCellSelectedIndex = row;
        
        [self expandArray];
    }
    
}

//this example adds 1 item
- (void)expandArray
{
    NSString *dstring = @"Boot Camp is back to the basics. We help you build a solid foundation so you have a much easier time managing your weight in the future. We do this by first having a deit preparation period of 7 days where we show you how to prepare for your upcoming diet. We then have a 21 day diet program with weekly workout videos that places you on a fast track of your weight loss goals.";
    //create an array of indexPaths
    [self.faqArray insertObject:dstring atIndex:_faqCellSelectedIndex + 1];

    [self.tableView reloadData];
}

//this example removes all but the first 3 items
- (void)retractArray
{
    NSRange range;
    range.location = _faqCellSelectedIndex + 1;
    range.length = 1;

    [self.faqArray removeObjectsInRange:range];
    [self.tableView reloadData];
    
    _faqCellSelectedIndex = -1;
}
//------------------------------------------------------------------------
// mark - Table view data source
//------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _faqArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"FAQTableViewCell";
    FAQTableViewCell *cell;
    
    if(_faqCellSelectedIndex != -1 && indexPath.row == _faqCellSelectedIndex + 1){
        cellIdentifier = @"FAQDescTableViewCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[FAQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.tableView = self.tableView;
        cell.controller = self;

        cell.lbl_FaqTitle.text = _faqArray[indexPath.row];
    }else{
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[FAQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.tableView = self.tableView;
        cell.controller = self;
        
        if (self.faqCellSelectedIndex == -1 || self.faqCellSelectedIndex == indexPath.row){
            cell.cellCoverView.hidden = YES;
            
            if(self.faqCellSelectedIndex == -1)
                [cell.img_check setImage:[UIImage imageNamed:@"ic_arrow_down.png"]];
            else
                [cell.img_check setImage:[UIImage imageNamed:@"ic_arrow_up.png"]];
        }
        else{
            cell.cellCoverView.hidden = NO;
            [cell.img_check setImage:[UIImage imageNamed:@"ic_arrow_down.png"]];
        }
        
        cell.lbl_FaqTitle.text = _faqArray[indexPath.row];
        
    }
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
