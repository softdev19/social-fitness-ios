//
//  ExerciseDatabaseCollectionViewCell.m
//  Diet Achiever
//
//  Created by Wang on 2/25/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ExerciseDatabaseCollectionViewCell.h"

@implementation ExerciseDatabaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectedFlag = false;
    self.imgExerciseSelected.hidden = YES;
    self.cellCoverTransView.hidden = YES;
}

- (IBAction) onClickSelct:(id)sender{
    self.selectedFlag = true;
       
    NSIndexPath *index = [self.collectionView indexPathForCell: self];
    
    if ([self.controller respondsToSelector:@selector(exerciseSelected:)]) {
        [self.controller performSelector:@selector(exerciseSelected:) withObject:index];
    }
}
@end
