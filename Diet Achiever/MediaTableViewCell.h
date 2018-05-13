//
//  MediaTableViewCell.h
//  Diet Achiever
//
//  Created by Wang on 9/15/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_author;
@property (weak, nonatomic) IBOutlet UILabel *lbl_like;
@property (weak, nonatomic) IBOutlet UILabel *lbl_favorites;
@end
