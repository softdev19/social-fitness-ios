//
//  CountDownEntity.m
//  Diet Achiever
//
//  Created by khs125 on 11/3/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "CountDownEntity.h"

@implementation CountDownEntity

- (id) initWithJson:(NSDictionary *)json{
    self = [super init];
    
    if([json objectForKey:@"days"])
        _days = [NSString stringWithFormat:@"%@", [json objectForKey:@"days"]];
    if([json objectForKey:@"hours"])
        _hours = [NSString stringWithFormat:@"%@", [json objectForKey:@"hours"]];
    if([json objectForKey:@"minutes"])
        _minutes = [NSString stringWithFormat:@"%@", [json objectForKey:@"minutes"]];
    if([json objectForKey:@"title"])
        _title = [NSString stringWithFormat:@"%@", [json objectForKey:@"title"]];
    
    return self;
}
@end
