//
//  ProgressMeasurmentMainViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/10/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "ProgressMeasurmentMainViewController.h"
#import "StringConstants.h"

@interface ProgressMeasurmentMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *testWebView;

@end

@implementation ProgressMeasurmentMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.   
 
//    _testWebView.opaque = NO;
//    _testWebView.backgroundColor = [UIColor clearColor];
//    _testWebView.scrollView.scrollEnabled = NO;
//    _testWebView.scrollView.bounces = NO;
//    
//    [self.testWebView loadHTMLString:[NSString stringWithFormat:@"<html><body text=\"#000000\"><p style=\"font-family:Helvetica;font-size:15; align:justify;\">%@</p></body></html>", @"Visa and PNC are bringing you an innovative way to get ready for kickoff like you've never seen before in this exclusive video.<br /><br />FULL VIDEO HERE: <font color=\"#2ec3ed\">http://visa.com/steelers</font>"] baseURL: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    
    cellIdentifier = @"ProgressMeasurementTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
