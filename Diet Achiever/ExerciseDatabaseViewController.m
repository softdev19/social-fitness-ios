//
//  ExerciseDatabaseViewController.m
//  Diet Achiever
//
//  Created by Wang on 1/26/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ExerciseDatabaseViewController.h"
#import "ExerciseDatabaseCollectionViewCell.h"

@interface ExerciseDatabaseViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *exerciseKindIndicators;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *exerciseKindCoverViews;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSInteger selectedIndex;
@end

@implementation ExerciseDatabaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initiation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.    
}

- (void) initiation{
    [self updateExerciseTab: 1];
    
    self.selectedIndex = -1;
}

- (IBAction)onClickCancelDismissVC:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

//-----------------------------------------------------------------------------------
// Mark - Exercise Kind Manager
//-----------------------------------------------------------------------------------
- (IBAction)onClickExerciseKindTabs:(id)sender{
    [self updateExerciseTab:[sender tag]];
}

- (void) updateExerciseTab:(NSInteger) tag{

    for( NSInteger i = 0; i < _exerciseKindIndicators.count ; i ++){
        UIView *indicator = _exerciseKindIndicators[i];
        UIView *coverTabView = _exerciseKindCoverViews[i];
        
        if( i == tag - 1){
            indicator.hidden = NO;
            coverTabView.hidden = YES;
        }else{
            indicator.hidden = YES;
            coverTabView.hidden = NO;
        }
    }
}

//-----------------------------------------------------------------------------------
// Mark - responder selector method
//-----------------------------------------------------------------------------------
- (void) exerciseSelected: (NSIndexPath *) indexPath {
    
    if(self.selectedIndex == indexPath.row)
        self.selectedIndex = -1;
    else
        self.selectedIndex = indexPath.row;
    
    
    [self.collectionView reloadData];
}
//-----------------------------------------------------------------------------------
// Mark - UICollectionView Delegate
//-----------------------------------------------------------------------------------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:      (NSInteger)section
{
    return 15;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(isPhoneWidth320){
        return CGSizeMake(82, 135);
    }
    else if(isPhoneWidth375){
       return CGSizeMake(100, 160);
    }
    else{
        return CGSizeMake(110, 170);
    }
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExerciseDatabaseCollectionViewCell *cell = (ExerciseDatabaseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"exerciseDatabaseCollectionTableView" forIndexPath:indexPath];
    
    cell.controller = self;
    cell.collectionView = self.collectionView;
    
    if(self.selectedIndex != -1 && self.selectedIndex == indexPath.row){
        
        cell.cellCoverTransView.hidden = YES;
        cell.imgExerciseSelected.hidden = NO;
        [cell.btn_select setBackgroundColor:[DIETMANAGER colorWithHexString:@"0xfc7165"]];
        [cell.btn_select setTitle:@"UNSELECT" forState:UIControlStateNormal];
        
    }else{
        if (self.selectedIndex == -1)
            cell.cellCoverTransView.hidden = YES;
        else
            cell.cellCoverTransView.hidden = NO;
        cell.imgExerciseSelected.hidden = YES;
        [cell.btn_select setBackgroundColor:[DIETMANAGER colorWithHexString:@"0x67d2a1"]];
        [cell.btn_select setTitle:@"SELECT" forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
  
}

@end
