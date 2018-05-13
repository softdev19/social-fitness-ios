//
//  FAQTableViewCell.h
//  Diet Achiever
//
//  Created by Wang on 2/27/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AcceleratorCalendarViewController.h"

@interface FAQTableViewCell : UITableViewCell
@property  UITableView *tableView;
@property   AcceleratorCalendarViewController *controller;

@property (weak, nonatomic) IBOutlet JWDynamicLabel *lbl_FaqTitle;
@property (weak, nonatomic) IBOutlet UIImageView *img_check;
@property (weak, nonatomic) IBOutlet UIView *cellCoverView;

@end
