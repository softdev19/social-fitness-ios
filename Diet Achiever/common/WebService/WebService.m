//
//  WebService.m
//  Media
//
//  Created by khs125 on 11/1/14.
//  Copyright (c) 2014 BaoAnh. All rights reserved.
//

#import "WebService.h"
#import "Util.h"

#define BOUNDARY @"------------0x0x0x0x0x0x0x0x"

@implementation WebService

static WebService *_webService;

+ (id)sharedInstant{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _webService = [[WebService alloc]init];
    });
    return _webService;
}
- (NSString *)subUrlFromApiName:(NSString *)apiName param:(NSDictionary *)param{
    NSString *subUrl = apiName;
    if (param) {
        NSString *keyValue;
        NSString *moreUrl = @"&";
        for (NSString *key in param.allKeys) {
            if (key.length > 0) {
                NSString *value = [param objectForKey:key];
                if (moreUrl.length == 1) {
                    keyValue = [NSString stringWithFormat:@"%@=%@", key, value];
                }else{
                    keyValue = [NSString stringWithFormat:@"&%@=%@", key, value];
                }
                moreUrl = [moreUrl stringByAppendingString:keyValue];
            }
        }
        subUrl = [subUrl stringByAppendingString:moreUrl];
    }
    return subUrl;
}
- (void)loadRequest:(NSString *)apiName param:(NSString *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSString *subUrl = [NSString stringWithFormat:@"%@/%@", apiName, param];
    NSString *urlString = [BASE_URL stringByAppendingString:subUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON of api %@: %@",apiName, responseObject);
        success(operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error of api %@: %@",apiName, error);
        failure(error);
    }];
}

- (void)getRequest:(NSString *)apiName param:(NSString *)param withSignature:(NSString*)signature withToken:(NSString*)token success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSString *subUrl;
    if(param)
        subUrl = [NSString stringWithFormat:@"%@/%@", apiName, param];
    else
        subUrl = [NSString stringWithFormat:@"%@", apiName];
    
    NSString *urlString = [BASE_URL stringByAppendingString:subUrl];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@", urlString] parameters:nil error:nil];
    
    if(signature && token)
    {
        [request setValue:[NSString stringWithFormat:@"%@",signature] forHTTPHeaderField:@"Diet-Achiever-Session-Signature"];
        [request setValue:[NSString stringWithFormat:@"%@",token] forHTTPHeaderField:@"Diet-Achiever-Session-Token"];
    }
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON of api %@: %@",subUrl, responseObject);
        success(operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error of api %@: %@",subUrl, error);
        
        //only for antar
        if(operation.responseString == nil || [operation.responseString isEqualToString:@""])
            failure(error);
        else{
            success(operation.responseString);
        }
    }];
    [op start];
}

- (void)postRequest:(NSString *)subUrl param:(NSString *)param withSignature:(NSString*)signature withToken:(NSString*)token success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
   
    NSString *urlString = [BASE_URL stringByAppendingString:subUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];    
  
    [request setHTTPMethod:@"POST"];
    //[request setValue: @"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: [param dataUsingEncoding:NSUTF8StringEncoding]];
    
    if(signature && token)
    {
        [request setValue:[NSString stringWithFormat:@"%@",signature] forHTTPHeaderField:@"Diet-Achiever-Session-Signature"];
        [request setValue:[NSString stringWithFormat:@"%@",token] forHTTPHeaderField:@"Diet-Achiever-Session-Token"];
    }
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON of api %@: %@",subUrl, responseObject);
        success(operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error of api %@: %@",subUrl, error);
        
        //only for antar
        if(operation.responseString == nil || [operation.responseString isEqualToString:@""])
            failure(error);
        else{
            success(operation.responseString);
        }
    }];
    [op start];
    
}

- (void)postImageRequest:(NSString *)subUrl fieldName:(NSString*)fieldName imageData:(NSData*)imageData withSignature:(NSString*)signature withToken:(NSString*)token success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{

    NSString *urlString = [BASE_URL stringByAppendingString:subUrl];

    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:20];
    [request setHTTPMethod:@"POST"];

    if(signature && token)
    {
        [request setValue:[NSString stringWithFormat:@"%@",signature] forHTTPHeaderField:@"Diet-Achiever-Session-Signature"];
        [request setValue:[NSString stringWithFormat:@"%@",token] forHTTPHeaderField:@"Diet-Achiever-Session-Token"];
    }
    
    id boundary = BOUNDARY;
    NSString *FileParamConstant = fieldName;
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //Description String
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"description"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"avatar file\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // add image data
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\nContent-Type: image/jpeg\r\n\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
    }                       
    // close form
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", (int)body.length];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:[NSURL URLWithString:urlString]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON of api %@: %@",subUrl, responseObject);
        success(operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error of api %@: %@",subUrl, error);
        failure(error);
    }];
    [op start];
    
//  Test code for Zames
//    NSData *imageData =  UIImageJPEGRepresentation(photo, 0.5);
//    
//    NSDictionary *params = @{
//                             
//                             };
//    
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@/%@",BASE_URL, ENDPOINT_UPLOAD_PHOTO] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData name:PARAM_UPLOAD_PHOTO_FILE_KEY fileName:@"photo.jpg" mimeType:@"image/jpeg"];
//    } error:nil];
//    
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSURLSessionUploadTask *uploadTask;
//    uploadTask = [manager
//                  uploadTaskWithStreamedRequest:request
//                  progress:^(NSProgress * _Nonnull uploadProgress) {
//                      dispatch_async(dispatch_get_main_queue(), ^{
//                      });
//                  }
//                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                  }];
//    
//    [uploadTask resume];
}


- (void)postVideoRequest:(NSString *)subUrl fieldName:(NSString*)fieldName videoData:(NSData*)videoData success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
   
    NSString *urlString = [BASE_URL stringByAppendingString:subUrl];
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    
    id boundary = BOUNDARY;
    NSString *FileParamConstant = fieldName;
   
    /// set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add video data
    
    if (videoData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"imagen.mp4\"\r\nContent-Type: video/mp4\r\n\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:videoData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", (int)body.length];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:[NSURL URLWithString:urlString]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON of api %@: %@",subUrl, responseObject);
        success(operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error of api %@: %@",subUrl, error);
        failure(error);
    }];
    [op start];
}


- (void)checkNetworkStatus{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                // -- Reachable -- //
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
            {
                // -- Not reachable -- //
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification"
                                                                message:@"Please confirm Wi-Fi state."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            break;
        }
        
    }];
}


@end
