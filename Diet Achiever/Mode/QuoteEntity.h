//
//  QuoteEntity.h
//  Diet Achiever
//
//  Created by khs125 on 11/3/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuoteEntity : NSObject
@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *authorTitle;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *message;

- (id) initWithJson:(NSDictionary *)json;
@end
