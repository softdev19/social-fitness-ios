//
//  UserManager.m
//  
//
//  Created by khs125 on 11/6/15.
//  Copyright © 2015 striver. All rights reserved.
//
#import <Security/Security.h>
#import "DietManager.h"


static DietManager *_dietManager;

@implementation DietManager

+ (id)sharedInstant{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dietManager = [[DietManager alloc]init];
    });    
    return _dietManager;
}

- (int)isLoginDone {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_LOGIN_DONE];
    int login = [[NSKeyedUnarchiver unarchiveObjectWithData:data] intValue];
    return login;
}
- (void)setLoginInfo:(int) flag{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[NSString stringWithFormat:@"%d",flag]];
    [[NSUserDefaults standardUserDefaults] setObject:data  forKey:KEY_LOGIN_DONE];
}


/*  App install info part  */
- (int)isInstallDone{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_APP_OPEN_DONE];
    int login = [[NSKeyedUnarchiver unarchiveObjectWithData:data] intValue];
    return login;
}
- (void)setInstallOpenInfo:(int)flag{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[NSString stringWithFormat:@"%d",flag]];
    [[NSUserDefaults standardUserDefaults] setObject:data  forKey:KEY_APP_OPEN_DONE];
}


#pragma mark - Setting User info
- (void)setUsernfo:(UserEntity *)user{
    _user = user;
    [self saveUserInfo:_user];
}
- (UserEntity *)getUserInfo{
    if(!_user){
        _user = [self loadUserInfo];
    }
    return _user;
}

- (void)saveUserInfo:(UserEntity *)user{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:data  forKey:KEY_LOGIN_USER];

}
- (UserEntity *)loadUserInfo{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_LOGIN_USER];
    UserEntity *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}

/*  Diet Progress Day */
- (int)getDietProgressDay{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_DIET_PROGRESS_DAY];
    int day = [[NSKeyedUnarchiver unarchiveObjectWithData:data] intValue];
    return day;
}
- (void)setDietProgressDay:(int)day{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[NSString stringWithFormat:@"%d",day]];
    [[NSUserDefaults standardUserDefaults] setObject:data  forKey:KEY_DIET_PROGRESS_DAY];
}

/*******************************************************************************************************/
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



-(CGSize)getSizeOfString:(NSString *)str
{
    CGSize maximumSize;
    
    if(isiPhone4 || isiPhone5){ //320
        maximumSize = CGSizeMake(275, 9999);
    } else if(isiPhone6){ //375
        maximumSize = CGSizeMake(335, 9999);
    }else if(isiPhone6plus){ //414
        maximumSize = CGSizeMake(370, 9999);
    }
    int brbrcount = [self countBrBr:str];
    int brcount = [self countBr:str];
    brcount = brcount - brbrcount*2;
    
    str = [self stringByStrippingHTML:str];
    
    UIFont *myFont = [UIFont fontWithName:@"Helvetica" size:15.5];
    
    CGSize myStringSize = [str sizeWithFont:myFont
                          constrainedToSize:maximumSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    if(brbrcount){
        NSString *tmp = @"a";
        CGSize size = [tmp sizeWithFont:myFont];
        myStringSize.height += (size.height + size.height*0.2)*brbrcount;
    }
    
    if(brcount){
        NSString *tmp = @"a";
        CGSize size = [tmp sizeWithFont:myFont];
        myStringSize.height += (size.height)*brcount;
    }
    
    return myStringSize;
}

-(CGSize)getSizeOfString:(NSString *)str withLength:(int) index withfont:(float)fontsize
{
    CGSize maximumSize;
    
    if(isiPhone4 || isiPhone5){ //320
        maximumSize = CGSizeMake(320 - index, 9999);
    } else if(isiPhone6){ //375
        maximumSize = CGSizeMake(375 - index, 9999);
    }else if(isiPhone6plus){ //414
        maximumSize = CGSizeMake(414 - index, 9999);
    }
    
    UIFont *myFont = [UIFont fontWithName:@"Helvetica" size:fontsize];
    
    CGSize myStringSize = [str sizeWithFont:myFont
                          constrainedToSize:maximumSize
                              lineBreakMode:NSLineBreakByWordWrapping];
    return myStringSize;
}

-(NSString *) stringByStrippingHTML:(NSString*)s{
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

-(int) countBr:(NSString*)str{
    int count = 0;
    NSUInteger length = [str length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [str rangeOfString: @"<br />" options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++; 
        }
    }
    return count;
}

-(int) countBrBr:(NSString*)str{
    int count = 0;
    NSUInteger length = [str length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [str rangeOfString: @"<br /><br />" options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++;
        }
    }
    return count;
}

- (NSDate*)correctDate:(NSString*)dateString
{
    NSArray *locals = [NSLocale preferredLanguages];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    for (NSString *identifier in locals)
    {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:identifier];
        dateFormat.locale = locale;
        NSDate *date = [dateFormat dateFromString:dateString];
        if (date)
            return date;
    }
    
    return nil;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
@end
