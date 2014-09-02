//
//  DGWikiNetworking.m
//  Wikipedia
//
//  Created by Dimas Gabriel on 8/31/14.
//  Copyright (c) 2014 Dimas Gabriel. All rights reserved.
//

#import "DGWikiNetworking.h"

typedef void (^BaseJSONCompletionBlock)(id result, NSError *error);

@interface DGWikiNetworking (Private)

@property (nonatomic, strong) NSURL *URL;

@end

@implementation DGWikiNetworking

+ (DGWikiNetworking *)netWorkingWithURL:(NSURL *)URL {
    
    static DGWikiNetworking *networking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[self alloc] initWithBaseURL:URL];
    });
    
    return networking;
}

- (instancetype)initWithBaseURL:(NSURL *)URL {
    
    if (self = [super initWithBaseURL:URL]) {
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.removesKeysWithNullValues = true;
        self.responseSerializer = responseSerializer;
        
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

- (void) getRequestWithParameters:(NSDictionary *)parameters
                         completionHandler:(BaseJSONCompletionBlock)completionHandler {
    
    NSMutableDictionary *p = [self defaultRequestParameters];
    [p addEntriesFromDictionary:parameters];
    
    [self GET:@"" parameters:p success:^(NSURLSessionDataTask *task, id responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionHandler(nil, error);
    }];
}

#pragma mark - Default Parameters
- (NSMutableDictionary *)defaultRequestParameters{
    return [NSMutableDictionary dictionaryWithObjects:@[@"json"] forKeys:@[@"format"]];
}

@end
