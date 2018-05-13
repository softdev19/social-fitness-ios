//
//  BootcampStateEntity.h
//  Diet Achiever
//
//  Created by khs125 on 11/3/16.
//  Copyright © 2016 summit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BootcampStateEntity : NSObject
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSString *totalDays;
@property (nonatomic, strong) NSString *type;

- (id) initWithJson:(NSDictionary *)json;
@end
