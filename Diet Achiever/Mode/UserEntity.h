//
//  SignupEntity.h
//  TheZones
//
//  Created by khs125 on 11/2/15.
//  Copyright © 2015 striver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject<NSCoding>
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *registration;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userId;


- (id) initWithJson:(NSDictionary *)json;

@end
