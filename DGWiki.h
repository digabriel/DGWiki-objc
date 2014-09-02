//
//  DGWiki.h
//  Wikipedia
//
//  Created by Dimas Gabriel on 8/31/14.
//  Copyright (c) 2014 Dimas Gabriel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGWikiImage.h"

#define DGWikiErrorDomain @"DGWikiErrorDomain"
#define DGWikiParseErrorCode -1

typedef void (^BaseArrayCompletionBlock)(NSArray *result, NSError *error);

@interface DGWiki : NSObject

@property (nonatomic, readonly) NSURL *APIURL;

+ (DGWiki *)sharedInstanceForWikipedia;
- (id)initWithWikiAPIURL:(NSURL *)wikiURL;

- (void) imagesOnPageWithTitle:(NSString *)pageTitle
     withCompletionHandler:(BaseArrayCompletionBlock)completionHandler;

@end
