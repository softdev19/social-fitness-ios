//
//  CountDownEntity.h
//  Diet Achiever
//
//  Created by khs125 on 11/3/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountDownEntity : NSObject
@property (nonatomic, strong) NSString *days;
@property (nonatomic, strong) NSString *hours;
@property (nonatomic, strong) NSString *minutes;
@property (nonatomic, strong) NSString *title;

- (id) initWithJson:(NSDictionary *)json;
@end
