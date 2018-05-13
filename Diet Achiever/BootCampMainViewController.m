//
//  AcceleratorMydayViewController.m
//  Diet Achiever
//
//  Created by Wang on 9/2/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "BootCampMainViewController.h"
#import "REFrostedViewController.h"
#import "StringConstants.h"
#import "MDHTMLLabel.h"

@interface BootCampMainViewController ()
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_mayday;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_mygroup;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_mycircut;
@property (weak, nonatomic) IBOutlet UIView *tab_indicator_option;

@property (weak, nonatomic) IBOutlet UIView *viewDietAchieverStatus;
@property (weak, nonatomic) IBOutlet UIView *viewTaskArticleStyle;
@property (weak, nonatomic) IBOutlet UIView *viewTaskVideoStyle;
@property (weak, nonatomic) IBOutlet UIView *viewTaskAudioStyle;
@property (weak, nonatomic) IBOutlet UIView *viewTaskRecipeStyle;

@property (weak, nonatomic) IBOutlet UIView *viewSubmitWeight;
@property (weak, nonatomic) IBOutlet UIView *viewSubmitThanks;


@property (weak, nonatomic) IBOutlet UIWebView *testArticleHtmlView;

@property (weak, nonatomic) IBOutletCollection(UIButton) NSArray *taskCompleteButtons;

@end

@implementation BootCampMainViewController

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

- (IBAction)onClickMenu:(id)sender {
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

// Tab Item Click
- (IBAction)onClickMyDay:(id)sender {
    [self updateIndicator:1];
    
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DailyTaskGuideBuddyViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}
- (IBAction)onClickMyGroup:(id)sender {
    [self updateIndicator:2];
    
}
- (IBAction)onClickMyCircut:(id)sender {
    [self updateIndicator:3];
    
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AcceleratorMyCircuitViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}
- (IBAction)onClickOptions:(id)sender {
    [self updateIndicator:4];
    
    //For test
    UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseDietPlanPickerViewController"];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

//My Day Alert view
- (IBAction)resetStatus:(id)sender {
    _viewDietAchieverStatus.hidden = NO;
}
- (IBAction)resetCalendar:(id)sender {
    UIViewController * calendarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AcceleratorCalendarViewController"];
    calendarVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.navigationController presentViewController:calendarVC animated:NO completion:nil];
}


- (IBAction)closePopupView:(id)sender {
    _viewDietAchieverStatus.hidden = YES;
}


- (void) initialize{
    _viewDietAchieverStatus.hidden = YES;
    _viewSubmitWeight.hidden = YES;
    _viewSubmitThanks.hidden = YES;
    
    //For test Article Html
    NSString *text = @"<p>Hunger can be a real pain when you are trying to lose weight!&nbsp; When you restrict food intake, appetite and hunger goes up, which drives you to overeat<em>.&nbsp; </em>We won&rsquo;t bore you with the details, but just want you to know your brain and body are hard at work to keep you alive.&nbsp; Most of the time when you are hungry, your body is working hard sending messages to your brain that you need to eat.</p><p>However, in our society we also have external cues that drive us to eat.&nbsp; Thing such as your environment (another social event), senses (ooh that donut smells good) and habits (I must have chips when I watch the game).&nbsp; Wow, it&rsquo;s no wonder our eating cues are so out- of -wack! When we are perfectly in tune with our hunger and satiety cues, we eat when physically hungry and stop when satisfied and we maintain a healthy body weight.&nbsp; Our energy, hunger and cravings are balanced.&nbsp; So what are some solutions to this madness?&nbsp; Mindful eating.&nbsp;</p><p><u>Here are 5 tips, click here to read more.</u></p><p>---------------------------------------</p><ol><li><strong>Learn your body signals</strong> Physical symptoms-is your stomach growling? Do you have a headache and are you getting dizzy? Mental symptoms-are you stressed?&nbsp; Are you aware of what you are putting in your mouth or are you just shoveling food in? Are you upset or emotionally distressed?</li><li><strong>Reset your hunger and satiety cues</strong> .One way to see if you are eating the right amount is to evaluate your hunger and satiety using the chart below. You never want to get so hungry that you are in hunger levels 1 and 2, as this will lead to binge eating!&nbsp; In general, when you are between 3 and 4, its time to eat. Typically, if you are around 5, you can stop eating.&nbsp; It will take some time to differentiate between hunger and cravings!&nbsp; Typically you will get back to hunger levels 3 and 4 every 3 to 4 hours.&nbsp;&nbsp;</li></ol><p>&nbsp;</p><table width=\"304\"><tbody><tr><td width=\"136\"><p><strong>Hunger Level</strong></p></td><td width=\"168\"><p><strong>Sensations and Symptoms</strong></p></td></tr><tr><td width=\\\"136\"><p><strong>1</strong></p></td><td width=\"168\"><p>Starving, weak, dizzy</p></td></tr><tr><td width=\"136\"><p><strong>2</strong></p></td><td width=\"168\"><p>Very hungry, cranky, low energy, a lot of stomach growling</p></td></tr><tr><td width=\"136\"><p><strong>3</strong></p></td><td width=\"168\"><p>Pretty hungry, stomach is growling a little</p></td></tr><tr><td width=\"136\"><p><strong>4</strong></p></td><td width=\"168\"><p>Starting to feel a little hungry</p></td></tr><tr><td width=\"136\"><p><strong>5</strong></p></td><td width=\"168\"><p>Satisfied, neither hungry nor full</p></td></tr><tr><td width=\"136\"><p><strong>6</strong></p></td><td width=\"168\"><p>A little full, pleasantly full</p></td></tr><tr><td width=\"136\"><p><strong>7</strong></p></td><td width=\"168\"><p>A little uncomfortable</p></td></tr><tr><td width=\"136\"><p><strong>8</strong></p></td><td width=\"168\"><p>Feeling stuffed</p></td></tr><tr><td width=\"136\"><p><strong>9</strong></p></td><td width=\"168\"><p>Very uncomfortable, stomach hurts</p></td></tr><tr><td width=\"136\"><p><strong>10</strong></p></td><td width=\"168\"><p>So full you feel sick</p></td></tr></tbody></table><p>&nbsp;</p><ol start=\"3\"><li><strong>Hunger is not an emergency!</strong> It&rsquo;s important to accept this feeling because it plays a vital role in your existence.&nbsp; Nor is it an emergency because there will always be time to eat.&nbsp; If you are unsure what true hunger feels like, try skipping a meal or two and experience the true sensation of hunger.&nbsp; It&rsquo;s a great exercise that teaches you that hunger is not an emergency and a little bit of hunger is expected during the fat loss process.</li></ol><p>&nbsp;</p><ol start=\"4\"><li><strong>Choose the right foods!</strong> Eating processed foods on its own will often increase the craving for more. Processed foods trigger our natural reward systems, and crank up your appetite. Are you tired? Sad? Unprocessed foods help keep hunger/satiety cues in check, and it&rsquo;s easier to make adjustments. Remember, if you&rsquo;re not hungry enough to eat broccoli and chicken, you&rsquo;re probably not hungry.</li><li><strong>Give yourself the unconditional permission to eat</strong>. Yes, that means you do not need to starve yourself! Eat for primarily physical reasons, rather than emotional.&nbsp; This will take some reconditioning and time to develop this skill.&nbsp; Be patient!</li></ol>";
    
    _testArticleHtmlView.opaque = NO;
    _testArticleHtmlView.backgroundColor = [UIColor clearColor];
    //_testArticleHtmlView.scrollView.scrollEnabled = NO;
    _testArticleHtmlView.scrollView.bounces = NO;
    [_testArticleHtmlView loadHTMLString:[NSString stringWithFormat:@"<html><body text=\"#000000\"><style>p{font-size:15px}</style><style>li{font-size:15px}</style>%@</body></body></html>", text] baseURL: nil];
    
    [self updateIndicator:1];
}

- (void) updateIndicator:(NSInteger) tag{
    _tab_indicator_mayday.hidden = YES;
    _tab_indicator_mygroup.hidden = YES;
    _tab_indicator_mycircut.hidden = YES;
    _tab_indicator_option.hidden = YES;
    
    switch (tag) {
        case 1:
             _tab_indicator_mayday.hidden = NO;
            break;
        case 2:
            _tab_indicator_mygroup.hidden = NO;
            break;
        case 3:
            _tab_indicator_mycircut.hidden = NO;
            break;
        case 4:
            _tab_indicator_option.hidden = NO;
            break;
            
        default:
            break;
    }

}

- (IBAction)onClickAcceleratorMyDayItems:(id)sender {
    NSInteger tag = [sender tag];
    
    switch (tag) {
        case DEF_TAG_MEAL_IDEA:
            
            break;
        case DEF_TAG_DAILY_TASK:{
            UIViewController *settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DailyTaskGuideBuddyViewController"];
            [self.navigationController pushViewController:settingViewController animated:YES];
        }
            break;
        case DEF_TAG_ARTICLE:
            
            break;
        case DEF_TAG_MOTIVATION:
            
            break;
        case DEF_TAG_VIDEO:
            
            break;
        case DEF_TAG_COMMUNITY:
            
            break;
            
        default:
            break;
    }
}



- (IBAction)onClickTaskComplete:(id)sender{
    
    NSInteger index = [sender tag];
    
    self.viewTaskAudioStyle.hidden = YES;
    self.viewTaskRecipeStyle.hidden = YES;
    self.viewTaskVideoStyle.hidden = YES;
    self.viewTaskArticleStyle.hidden = YES;
    
    switch (index) {
        case 0:
            self.viewTaskAudioStyle.hidden = NO;
            break;
        case 1:
            self.viewTaskArticleStyle.hidden = NO;
            break;
        case 2:
            self.viewTaskRecipeStyle.hidden = NO;
            break;
        case 3:
            self.viewTaskVideoStyle.hidden = NO;
            break;
        case 4:
            self.viewTaskArticleStyle.hidden = NO;
            break;
        case 5:
            self.viewTaskVideoStyle.hidden = NO;
            break;

        default:
            break;
    }
}

@end
