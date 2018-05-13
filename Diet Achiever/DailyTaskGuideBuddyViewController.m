//
//  DailyTaskGuideBuddyViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/18/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "DailyTaskGuideBuddyViewController.h"

@interface DailyTaskGuideBuddyViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *dailyTaskGuideView;
@property (weak, nonatomic) IBOutlet UIView *dailyTaskSelectedBuddyView;
@property (weak, nonatomic) IBOutlet UIView *dialyTaskBuddySelectView;

@end

@implementation DailyTaskGuideBuddyViewController

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
    self.dailyTaskSelectedBuddyView.hidden = YES;
    self.dialyTaskBuddySelectView.hidden = YES;
}

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


- (IBAction)onClickGuideNext:(id)sender {
    self.dailyTaskGuideView.hidden = YES;
    self.dialyTaskBuddySelectView.hidden = NO;
}

- (IBAction)onClickBuddySelectedGo:(id)sender {
}
- (IBAction)onClickBuddySelectedBack:(id)sender {
    self.dialyTaskBuddySelectView.hidden = NO;
    self.dailyTaskSelectedBuddyView.hidden = YES;
}

#pragma mark - CollectionView
#pragma mark DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:      (NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"dailyTaskBuddyCollectionTableView" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.dialyTaskBuddySelectView.hidden = YES;
    self.dailyTaskSelectedBuddyView.hidden = NO;
}

@end
