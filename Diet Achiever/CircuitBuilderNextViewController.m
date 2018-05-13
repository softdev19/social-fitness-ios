//
//  CircuitBuilderNextViewController.m
//  Diet Achiever
//
//  Created by Wang on 1/26/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "CircuitBuilderNextViewController.h"
#import "ExerciseDatabaseViewController.h"
#import "ExerciseSetsListViewController.h"

// TTSlidingPage
#import "TTSlidingPagesDataSource.h"
#import "TTSlidingPageDelegate.h"
#import "TTScrollSlidingPagesController.h"
#import "TTSlidingPage.h"
#import "TTSlidingPageTitle.h"

@interface CircuitBuilderNextViewController () <TTSlidingPagesDataSource, TTSlidingPageDelegate>
@property (weak, nonatomic) IBOutlet UIView *circuitExerciseSetListView;
@property (weak, nonatomic) IBOutlet UIView *listArrowLeftView;
@property (weak, nonatomic) IBOutlet UIView *listArrowRightView;

@property (strong, nonatomic) TTScrollSlidingPagesController *slider;
@property  NSInteger currentExerciseListIndex;
@end

@implementation CircuitBuilderNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initeSliderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickPrevious:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initeSliderView{
    //initial setup of the TTScrollSlidingPagesController.
    self.slider = [[TTScrollSlidingPagesController alloc] init];
    self.slider.titleScrollerHeight = 0;
   
    self.slider.disableUIPageControl = YES;
    self.slider.initialPageNumber = 0;
    self.slider.pagingEnabled = YES;
    self.slider.zoomOutAnimationDisabled = YES;
    self.slider.disableTitleShadow = YES;
    
    //set the datasource.
    self.slider.dataSource = self;
    self.slider.delegate = self;
    
    self.slider.view.frame = self.circuitExerciseSetListView.frame;
    
    [self.circuitExerciseSetListView addSubview:self.slider.view];
    [self addChildViewController:self.slider];
    
    [self showListArrowView: 0 withTotal: 3];
}

- (void) showListArrowView:(NSInteger) currentIndex withTotal:(NSInteger) totalCount{
    
    self.currentExerciseListIndex = currentIndex;
    
    if(currentIndex == 0){
        self.listArrowLeftView.hidden = YES;
        self.listArrowRightView.hidden = NO;
    }
    else if(currentIndex == totalCount - 1){
        self.listArrowLeftView.hidden = NO;
        self.listArrowRightView.hidden = YES;
    }
    else{
        self.listArrowLeftView.hidden = NO;
        self.listArrowRightView.hidden = NO;
    }
}

//---------------------------------------------------------------------------------------
// Mark:- #pragma mark Arrow Action methods
//---------------------------------------------------------------------------------------

- (IBAction)onClickArrowRightBtn:(id)sender {
    //if index < total count
    if(self.currentExerciseListIndex < 2){
        [self.slider scrollToPage:(int)self.currentExerciseListIndex + 1 animated: YES];
        [self showListArrowView:self.currentExerciseListIndex + 1  withTotal: 3];
    }
}

- (IBAction)onClickArrowLeftBtn:(id)sender {
    //if index > 0
    if(self.currentExerciseListIndex > 0){
        [self.slider scrollToPage:(int)self.currentExerciseListIndex - 1 animated: YES];
        [self showListArrowView:self.currentExerciseListIndex - 1  withTotal: 3];
    }
}

//---------------------------------------------------------------------------------------
// Mark:- TTSlidingPagesDataSource methods
//---------------------------------------------------------------------------------------
-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return 3; //just return 7 pages as an example
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index{
    ExerciseSetsListViewController *viewController;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ExerciseSetsListViewController"];
    viewController.controller = self;
    return [[TTSlidingPage alloc] initWithContentViewController:viewController];
}

-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    TTSlidingPageTitle *title;
    //all other pages just use a simple text header
    title = [[TTSlidingPageTitle alloc] initWithHeaderText:[NSString stringWithFormat:@"Page %d", index+1]];
    
    return title;
}

-(void)didScrollToViewAtIndex:(NSUInteger)index{
    
    [self showListArrowView: index withTotal: 3];
}


//---------------------------------------------------------------------------------------
// Mark:- Exercise DataBase
//---------------------------------------------------------------------------------------

- (void) showExerciseDatabaseSettingView {

    ExerciseDatabaseViewController *exerciseDatabaseVC = [[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"ExerciseDatabaseViewController"];
    exerciseDatabaseVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.navigationController presentViewController:exerciseDatabaseVC animated:NO completion:nil];

}

@end
