//
//  StringConstants.h
//  Diet Achiever
//
//  Created by khs125 an on 5/24/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BASE_URL                                @"http://api.dietachiever.com/v1.1"

/*--------------------------------- Diet Achiever api suburls ------------------------------------*/
/* Login part */
#define SUB_URL_LOGIN_CLASSIC                   @"/account/login/classic"
#define SUB_URL_LOGIN_FACEBOOK                  @"/account/login/facebook"
#define SUB_URL_LOGIN_PING                      @"/account/login/ping"
#define SUB_URL_LOGIN_FORGOT_PWD                @"/account/forgot"
#define SUB_URL_ACCOUNT_CREATE                  @"/account/create"
#define SUB_URL_ACCOUNT_ABOUT                   @"/account/about"
#define SUB_URL_ACCOUNT_ABOUT_META              @"/account/about/meta"
#define SUB_URL_ACCOUNT_AVATAR_UPLOAD           @"/account/avatar/upload"
#define SUB_URL_ACCOUNT_AVATAR_SKIP             @"/account/avatar/skip"
#define SUB_URL_ACCOUNT_INVITE                  @"/account/invite"
#define SUB_URL_ACCOUNT_INVITE_SKIP             @"/account/invite/skip"

/* Dashboard part */
#define SUB_URL_BOOTCAMP_DASHBOARD_PREPARATION  @"/bootcamp/dashboard/preparation"


/*-------------------------------------- Menu item -----------------------------------------------*/
#define DEF_MENU_HOME                       0
#define DEF_MENU_COACHING                   1
#define DEF_MENU_ACCELERATOR                2
#define DEF_MENU_HABIT                      3
#define DEF_MENU_PROGRESS                   4
#define DEF_MENU_COMMUNITY                  5
#define DEF_MENU_RESCUE                     6
#define DEF_MENU_SHOPPING                   7
#define DEF_MENU_RECIPES                    8
#define DEF_MENU_LIFESTYLE                  9
#define DEF_MENU_EXERCISE                   10
#define DEF_MENU_PERSONAL                   11
#define DEF_MENU_EXPERT                     12
#define DEF_MENU_MEMBERSHIP                 13
#define DEF_MENU_SETTING                    14


/*----------------------------------------- SEGUE ------------------------------------------------*/
//PROGRESS
#define K_SEGUE_PRO_MEASUREMENT_CONTROLLER      @"SEGUE_PRO_MEASUREMENT"
#define K_SEGUE_PRO_BIOMARKER_CONTROLLER        @"SEGUE_PRO_BIOMARKER"
#define K_SEGUE_PRO_MYIMAGE_CONTROLLER          @"SEGUE_PRO_IMAGE"
#define K_SEGUE_PRO_MYGOAL_CONTROLLER           @"SEGUE_PRO_GOAL"

//COMMUNITY
#define K_SEGUE_COMMU_SHARE_CONTROLLER          @"SEGUE_COMMU_SHARE"
#define K_SEGUE_COMMU_SELFY_CONTROLLER          @"SEGUE_COMMU_SELFY"
#define K_SEGUE_COMMU_FORUM_CONTROLLER          @"SEGUE_COMMU_FORUM"

//RECIPES
#define K_SEGUE_RECIPES_CATEGORIES              @"SEGUE_RECIPES_CATEGORIES"
#define K_SEGUE_RECIPES_FAVORITE                @"SEGUE_RECIPES_FAVORITE"
#define K_SEGUE_RECIPES_TOPRATED                @"SEGUE_RECIPES_TOPRATED"
#define K_SEGUE_RECIPES_RECENT                  @"SEGUE_RECIPES_RECENT"

//SHOPPING
#define K_SEGUE_SHOPPING_GROCER                 @"SEGUE_SHOPPING_GROCER"
#define K_SEGUE_SHOPPING_MYCART                 @"SEGUE_SHOPPING_MYCART"
#define K_SEGUE_SHOPPING_MEALIDEAS              @"SEGUE_SHOPPING_MEALIDEAS"

//RESCUE
#define K_SEGUE_RESCUE_SITUATION                @"SEGUE_RESCUE_SITUATION"
#define K_SEGUE_RESCUE_VIDEO                    @"SEGUE_RESCUE_VIDEO"

/*-------------------------------------Notification name-----------------------------------------*/
#define NAME_NOTIFI_GOTO_LOGIN                  @"gotoLoginFirstViewControllers"
#define NAME_NOTIFI_GOTO_LOGIN_TYPE             @"gotoLoginInputViewControllers"

/*---------------------------------Accelerator My day items tags---------------------------------*/
#define DEF_TAG_MEAL_IDEA                       10
#define DEF_TAG_DAILY_TASK                      11
#define DEF_TAG_ARTICLE                         12
#define DEF_TAG_MOTIVATION                      13
#define DEF_TAG_VIDEO                           14
#define DEF_TAG_COMMUNITY                       15


/*-------------------------------------Accelerator Type------------------------------------------*/
#define DEF_ACCELERATOR_TYPE_BOOTCAMP           1
#define DEF_ACCELERATOR_TYPE_VETERANS           2

/*------------------------------------Diet BootCamp Day Step-------------------------------------*/
#define DEF_STEP_DIET_PREPARATION_DAY                       7       // pre 7
#define DEF_STEP_DIET_FIRST_SEVEN_DAY                       14      // diet 7
#define DEF_STEP_DIET_COMPLETE_DAY                          28      // diet +14
#define DEF_STEP_METABOLIC_RESET_COMPLETED_DAY              43      // metabolic 15, Next Challenge Day


/*--------------------------------- Intro image array --------------------------------------------*/
#define FTUE_IMAGE_LIST [NSArray arrayWithObjects:@"intro_home", @"img_intro_frist", @"img_intro_second", @"img_intro_third", @"img_intro_four", nil]

/*--------------------------------- Task Color String --------------------------------------------*/
#define STR_TASK_SELECTED_COLOR_LIST [NSArray arrayWithObjects:@"0Xffffff", @"0XB7eafc", @"0Xa1edca", @"0Xe2a4ed", @"0Xfce5ae", @"0Xfec49c", @"0Xffb4ad" nil]
#define STR_TASK_MAIN_COLOR_LIST [NSArray arrayWithObjects:@"0Xd5d5d5", @"0X68bfde", @"0X67d2a1", @"0Xba68c8", @"0Xf7cf70", @"0Xff9751", @"0Xfc7165" nil]

/*----------------------------------FAQ Strings---------------------------------------------------*/
#define FAQ_Q1  @"What is Boot Camp?"
#define FAQ_Q2  @"What is a Diet Buddy?"
#define FAQ_Q3  @"How do I choose my diet plan?"
#define FAQ_Q4  @"What are my options for cancelling?"
#define FAQ_Q5  @"How do I pause Boot Camp?"
#define FAQ_Q6  @"How do I change my Account preferences?"
#define FAQ_Q7  @"What is the average wing speed of a Swallow?"

#define FAQ_Q_LIST [NSArray arrayWithObjects: FAQ_Q1, FAQ_Q2, FAQ_Q3, FAQ_Q4, FAQ_Q5, FAQ_Q6, FAQ_Q7,nil]




