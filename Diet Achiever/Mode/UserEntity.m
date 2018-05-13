//
//  SignupEntity.m
//  TheZones
//
//  Created by khs125 on 11/2/15.
//  Copyright © 2015 striver. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity


- (id) initWithJson:(NSDictionary *)json{
    self = [super init];
    
    if([json objectForKey:@"avatar"])
        _avatar = [NSString stringWithFormat:@"%@", [json objectForKey:@"avatar"]];
    if([json objectForKey:@"displayName"])
        _displayName = [NSString stringWithFormat:@"%@", [json objectForKey:@"displayName"]];
    if([json objectForKey:@"firstName"])
        _firstName = [NSString stringWithFormat:@"%@",[json objectForKey:@"firstName"]];
    if([json objectForKey:@"lastName"])
        _lastName = [NSString stringWithFormat:@"%@",[json objectForKey:@"lastName"]];
    if([json objectForKey:@"registration"])
        _registration = [NSString stringWithFormat:@"%@",[json objectForKey:@"registration"]];
    if([json objectForKey:@"status"])
        _status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
    if([json objectForKey:@"signature"])
        _signature = [NSString stringWithFormat:@"%@",[json objectForKey:@"signature"]];
    if([json objectForKey:@"token"])
        _token = [NSString stringWithFormat:@"%@",[json objectForKey:@"token"]];
    if([json objectForKey:@"userId"])
        _userId = [NSString stringWithFormat:@"%@",[json objectForKey:@"userId"]];
    
    return self;
}



- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_avatar forKey:@"avatar"];
    [aCoder encodeObject:_displayName forKey:@"displayName"];
    [aCoder encodeObject:_firstName forKey:@"firstName"];
    [aCoder encodeObject:_lastName forKey:@"lastName"];
    [aCoder encodeObject:_registration forKey:@"registration"];
    [aCoder encodeObject:_status forKey:@"status"];
    [aCoder encodeObject:_signature forKey:@"signature"];
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_userId forKey:@"userId"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        _avatar = [aDecoder decodeObjectForKey:@"avatar"];
        _displayName = [aDecoder decodeObjectForKey:@"displayName"];
        _firstName = [aDecoder decodeObjectForKey:@"firstName"];
        _lastName = [aDecoder decodeObjectForKey:@"lastName"];
        _registration = [aDecoder decodeObjectForKey:@"registration"];
        _status = [aDecoder decodeObjectForKey:@"status"];
        _signature = [aDecoder decodeObjectForKey:@"signature"];
        _token = [aDecoder decodeObjectForKey:@"token"];
        _userId = [aDecoder decodeObjectForKey:@"userId"];
    }
    return self;
}

@end
