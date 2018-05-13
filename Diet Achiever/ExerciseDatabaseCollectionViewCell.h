//
//  ExerciseDatabaseCollectionViewCell.h
//  Diet Achiever
//
//  Created by Wang on 2/25/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseDatabaseViewController.h"

@interface ExerciseDatabaseCollectionViewCell : UICollectionViewCell
@property  UICollectionView *collectionView;
@property   ExerciseDatabaseViewController *controller;

@property (weak, nonatomic) IBOutlet UIView     *cellCoverTransView;
@property (weak, nonatomic) IBOutlet UIImageView *imgExerciseView;
@property (weak, nonatomic) IBOutlet UIImageView *imgExerciseSelected;
@property (weak, nonatomic) IBOutlet UILabel    *lbl_title;
@property (weak, nonatomic) IBOutlet UIButton   *btn_select;

@property Boolean selectedFlag;
@end
