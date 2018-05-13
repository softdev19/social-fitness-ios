//
//  BootcampStateEntity.m
//  Diet Achiever
//
//  Created by khs125 on 11/3/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "BootcampStateEntity.h"

@implementation BootcampStateEntity
- (id) initWithJson:(NSDictionary *)json{
    self = [super init];
    
    if([json objectForKey:@"currentDay"])
        _currentDay = [NSString stringWithFormat:@"%@", [json objectForKey:@"currentDay"]];
    if([json objectForKey:@"totalDays"])
        _totalDays = [NSString stringWithFormat:@"%@", [json objectForKey:@"totalDays"]];
    if([json objectForKey:@"type"])
        _type = [NSString stringWithFormat:@"%@", [json objectForKey:@"type"]];
    
    return self;
}
@end
