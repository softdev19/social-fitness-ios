//
//  CommunityMainViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "CommunityMainViewController.h"
#import "CommunityTabContainerViewController.h"

@interface CommunityMainViewController () 
@property (weak, nonatomic) IBOutlet UIView     *tab_share_indicator;
@property (weak, nonatomic) IBOutlet UIView     *tab_self_indicator;
@property (weak, nonatomic) IBOutlet UIView     *tab_forum_indicator;

@property (strong, nonatomic) CommunityTabContainerViewController *containerView;
@end

@implementation CommunityMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"embedcontainer"]) {
        self.containerView=segue.destinationViewController;
    }
}


- (IBAction)onClickShareTab:(id)sender {
   // [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_COMMU_SHARE_CONTROLLER];
   // [self updateIndicator:1];
    
    [self onShareLink];
}
- (IBAction)onClickSelfyTab:(id)sender {
    //[self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_COMMU_SELFY_CONTROLLER];
    //[self updateIndicator:2];
    
    UIViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommunitySelfyViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];

}
- (IBAction)onClickForumTab:(id)sender {
    [self.containerView swapViewControllersForSegueIdentifier:K_SEGUE_COMMU_FORUM_CONTROLLER];
    [self updateIndicator:3];
}

- (void) onShareLink {
    NSMutableArray * objectToShare = [[NSMutableArray alloc] init];
    NSString* url ;
    url = [NSString stringWithFormat:@"This is diet share"];
   
    
    [objectToShare addObject:url];
    UIActivityViewController* controller = [[UIActivityViewController alloc] initWithActivityItems:objectToShare applicationActivities:nil];
    
    // Exclude all activities except AirDrop.
    NSArray *excludedActivities = nil;
    controller.excludedActivityTypes = excludedActivities;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
        controller.popoverPresentationController.sourceView = self.view;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void) initialize{
    [self updateIndicator:3];
    
    //[self updateIndicator:0];
}

- (void) updateIndicator:(NSInteger) tag{
    _tab_share_indicator.hidden = YES;
    _tab_self_indicator.hidden = YES;
    _tab_forum_indicator.hidden = YES;
    
    switch (tag) {
        case 1:
            _tab_share_indicator.hidden = NO;
            break;
        case 2:
            _tab_self_indicator.hidden = NO;
            break;
        case 3:
            _tab_forum_indicator.hidden = NO;
            break;
            
        default:
            break;
    }
    
}

@end
