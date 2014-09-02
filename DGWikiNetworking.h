//
//  DGWikiNetworking.h
//  Wikipedia
//
//  Created by Dimas Gabriel on 8/31/14.
//  Copyright (c) 2014 Dimas Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^BaseJSONCompletionBlock)(id result, NSError *error);

@interface DGWikiNetworking : AFHTTPSessionManager

+ (DGWikiNetworking *)netWorkingWithURL:(NSURL *)URL;

- (void) getRequestWithParameters:(NSDictionary *)parameters
                completionHandler:(BaseJSONCompletionBlock)completionHandler;

@end
