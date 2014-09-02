//
//  DGWiki.m
//  Wikipedia
//
//  Created by Dimas Gabriel on 8/31/14.
//  Copyright (c) 2014 Dimas Gabriel. All rights reserved.
//

#import "DGWiki.h"
#import "DGWikiNetworking.h"

@interface DGWiki () {
    DGWikiNetworking *networking;
}

@end

@implementation DGWiki

+ (DGWiki *)sharedInstanceForWikipedia {
    static DGWiki *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DGWiki alloc]
                          initWithWikiAPIURL:[NSURL URLWithString:@"http://en.wikipedia.org/w/api.php"]];
    });
    
    return sharedInstance;
}

- (id)initWithWikiAPIURL:(NSURL *)wikiURL {
    if (self = [super init]) {
        _APIURL = wikiURL;
        networking = [DGWikiNetworking netWorkingWithURL:self.APIURL];
    }
    
    return self;
}

/* Completion Handler contains an array of DGWikiImages objects */
- (void) imagesOnPageWithTitle:(NSString *)pageTitle
         withCompletionHandler:(BaseArrayCompletionBlock)completionHandler {
   
    NSDictionary *params = @{@"action" : @"query",
                             @"titles" : pageTitle,
                             @"generator" : @"images",
                             @"prop" : @"imageinfo",
                             @"iiprop" : @"url"};
    
    [networking getRequestWithParameters:params completionHandler:^(id result, NSError *error) {
        if (error || !result) {
            completionHandler(nil, error);
            return;
        }
        
        error = [NSError errorWithDomain:DGWikiErrorDomain code:DGWikiParseErrorCode userInfo:nil];
        
        NSDictionary *query = [result objectForKey:@"query"];
        if (!query) {
            completionHandler(nil, error);
            return;
        }
        
        NSDictionary *pages = [query objectForKey:@"pages"];
        if (!pages) {
            completionHandler(nil, error);
            return;
        }
        
        NSArray *allImages = [pages allValues];
        NSMutableArray *returnArray = [NSMutableArray arrayWithCapacity:allImages.count];
        
        for (NSDictionary *imageDIC in allImages) {
            DGWikiImage *image = [[DGWikiImage alloc] initWithJSONDictionary:imageDIC];
            [returnArray addObject:image];
        }
        
        completionHandler(returnArray, nil);
    }];
}

@end
