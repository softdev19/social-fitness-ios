//
//  DietManager.h
//  
//
//  Created by khs125 on 11/6/15.
//  Copyright © 2015 striver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserEntity.h"

#define DIETMANAGER [DietManager sharedInstant]


#define KEY_LOGIN_DONE              @"KEY_LOGIN_DONE"
#define KEY_APP_OPEN_DONE           @"KEY_APP_OPEN_DONE"
#define KEY_LOGIN_USER              @"KEY_LOGIN_USER"
#define KEY_DIET_PROGRESS_DAY       @"KEY_DIET_PROGRESS_DAY"

@interface DietManager : NSObject{
    
}

@property (nonatomic, strong) UserEntity *user;

@property int running;

+ (id)sharedInstant;

/*********************************************************************/

/*  Login part  */
- (int)isLoginDone;
- (void)setLoginInfo:(int)flag;

/*  App install info part  */
- (int)isInstallDone;
- (void)setInstallOpenInfo:(int)flag;

/*  Set Login User */
- (void)setUsernfo:(UserEntity *)user;
- (UserEntity *)getUserInfo;

- (void)saveUserInfo:(UserEntity *)user;
- (UserEntity *)loadUserInfo;

/*  Diet Progress Day */
- (int)getDietProgressDay;
- (void)setDietProgressDay:(int)day;

/*********************** other global functions********************/
-(UIColor*)colorWithHexString:(NSString*)hex;
-(CGSize)getSizeOfString:(NSString *)str;
-(CGSize)getSizeOfString:(NSString *)str withLength:(int) index withfont:(float)fontsize;
- (NSDate*)correctDate:(NSString*)dateString;
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
@end

