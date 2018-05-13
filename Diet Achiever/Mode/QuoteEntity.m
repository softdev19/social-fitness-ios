//
//  QuoteEntity.m
//  Diet Achiever
//
//  Created by khs125 on 11/3/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import "QuoteEntity.h"

@implementation QuoteEntity
- (id) initWithJson:(NSDictionary *)json{
    self = [super init];
    
    if([json objectForKey:@"authorId"])
        _authorId = [NSString stringWithFormat:@"%@", [json objectForKey:@"authorId"]];
    if([json objectForKey:@"authorName"])
        _authorName = [NSString stringWithFormat:@"%@", [json objectForKey:@"authorName"]];
    if([json objectForKey:@"authorTitle"])
        _authorTitle = [NSString stringWithFormat:@"%@", [json objectForKey:@"authorTitle"]];
    if([json objectForKey:@"avatarUrl"])
        _avatarUrl = [NSString stringWithFormat:@"%@", [json objectForKey:@"avatarUrl"]];
    if([json objectForKey:@"day"])
        _day = [NSString stringWithFormat:@"%@", [json objectForKey:@"day"]];
    if([json objectForKey:@"message"])
        _message = [NSString stringWithFormat:@"%@", [json objectForKey:@"message"]];
    
    return self;
}
@end
