//
//  ExerciseCircuitTimerViewController.m
//  Diet Achiever
//
//  Created by Wang on 1/25/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ExerciseCircuitTimerViewController.h"
#import "UIImage+animatedGIF.h"
#import "UIImage+GIF.h"

@interface ExerciseCircuitTimerViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img_exercise_player;
@property (weak, nonatomic) IBOutlet UILabel *circuitPlayCountDownLabel;

@property UIImage *ImageData;
@property NSTimer *gifPlayTimer;
@property NSTimer *totalEstimateTimer;
@property NSInteger currentIndex;
@property int currMinute;
@property int currSeconds;
@end

@implementation ExerciseCircuitTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initationGifImageView: 0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initationGifImageView:(NSInteger) initIndex{
    self.currentIndex = initIndex;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"10D" withExtension:@"gif"];
    self.ImageData = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    self.img_exercise_player.image = self.ImageData.images[initIndex];

    float secs = self.ImageData.duration/[self.ImageData.images count];
    [self.gifPlayTimer invalidate];
    self.gifPlayTimer = [NSTimer scheduledTimerWithTimeInterval:secs target:self  selector:@selector(changeToNextImage) userInfo:nil repeats:YES];
    
    // Estimate Timer setting
    // repeatcount = 10
    _currMinute = self.ImageData.duration * 10 / 60;
    _currSeconds = (int)self.ImageData.duration * 10 % 60;
    [self estimateCountDownStart];
}

-(void)changeToNextImage
{
    self.currentIndex++;
    if(self.currentIndex == [self.ImageData.images count])
        self.currentIndex = 0;
    self.img_exercise_player.image = self.ImageData.images[_currentIndex];
}

//--------------------------------------------------------
// Mark - Total Estimate Timer
//--------------------------------------------------------
-(void)estimateCountDownStart
{
    self.totalEstimateTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(estimateTimerFired) userInfo:nil repeats:YES];
    
}
-(void)estimateTimerFired
{
    if((_currMinute>0 || _currSeconds>=0) && _currMinute>=0)
    {
        if(_currSeconds==0)
        {
            _currMinute-=1;
            _currSeconds=59;
        }
        else if(_currSeconds>0)
        {
            _currSeconds-=1;
        }
        if(_currMinute>-1)
        {
            //show text
            self.circuitPlayCountDownLabel.text = [NSString stringWithFormat:@"%02d : %02d", _currMinute, _currSeconds];
        }
    }
    else
    {
        [self.totalEstimateTimer invalidate];
    }
}

//--------------------------------------------------------
// Mark - Gif Play Control
//--------------------------------------------------------
- (IBAction)onRefreshPlayGif:(id)sender{
    [self initationGifImageView: 0];
}

- (IBAction)onPlayGif:(id)sender{
    [self initationGifImageView:_currentIndex];
}

- (IBAction)onPauseGif:(id)sender{
    [self.gifPlayTimer invalidate];
    self.img_exercise_player.image = self.ImageData.images[_currentIndex];
}

- (IBAction)onCancelGif:(id)sender{
    
}



@end
