//
//  WebService.h
//  Media
//
//  Created by khs125 on 11/1/14.
//  Copyright (c) 2014 BaoAnh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "StringConstants.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "Util.h"
#import "UIAlertView+Starlet.h"
#import "AppDelegate.h"


#define FIELDNAME_USERPHOTO     @"userphoto"

#define RESPOND_STATUS_SUCCESS  200



#define STATUS_OK               @"ok"

#define WEBSERVICE      [WebService sharedInstant]


@interface WebService : NSObject

+ (id)sharedInstant;

- (void)getRequest:(NSString *)apiName param:(NSString *)param withSignature:(NSString*)signature withToken:(NSString*)token success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)loadRequest:(NSString *)apiName param:(NSString *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)postRequest:(NSString *)subUrl param:(NSString *)param withSignature:(NSString*)signature withToken:(NSString*)token success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)postImageRequest:(NSString *)subUrl fieldName:(NSString*)fieldName imageData:(NSData*)imageData withSignature:(NSString*)signature withToken:(NSString*)token success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
-(void)postVideoRequest:(NSString *)subUrl fieldName:(NSString*)fieldName videoData:(NSData*)videoData success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)checkNetworkStatus;

    
@end
