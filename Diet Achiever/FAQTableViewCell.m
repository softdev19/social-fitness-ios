//
//  FAQTableViewCell.m
//  Diet Achiever
//
//  Created by Wang on 2/27/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "FAQTableViewCell.h"

@implementation FAQTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)onClickSelectBtn:(id)sender {
    
    NSIndexPath *index = [self.tableView indexPathForCell: self];
    
    if ([self.controller respondsToSelector:@selector(faqQuestionSelected:)]) {
        [self.controller performSelector:@selector(faqQuestionSelected:) withObject:index];
    }
}

@end
