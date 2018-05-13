//
//  ExerciseZoneDataBaseViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/23/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ExerciseZoneDataBaseViewController.h"

@interface ExerciseZoneDataBaseViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet JWDynamicLabel *exerciseSubTitle;
@property (weak, nonatomic) IBOutlet UIView *exeZoneDetailView;

@end

@implementation ExerciseZoneDataBaseViewController

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
    self.exeZoneDetailView.hidden = YES;
    self.exerciseSubTitle.text = [NSString stringWithFormat:@"%@ EXERCISES", self.exeZoneString.uppercaseString];
}


- (IBAction)onClickCancelDetailView:(id)sender {
    self.exeZoneDetailView.hidden = YES;
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
        return CGSizeMake(87, 110);
    }
    else if(isPhoneWidth375){
        return CGSizeMake(105, 135);
    }
    else{
        return CGSizeMake(115, 145);
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"exerciseZoneDatabaseCollectionTableView" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.exeZoneDetailView.hidden = NO;
}

@end
