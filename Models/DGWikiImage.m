//
//  DGWikiImage.m
//  Wikipedia
//
//  Created by Dimas Gabriel on 8/31/14.
//  Copyright (c) 2014 Dimas Gabriel. All rights reserved.
//

#import "DGWikiImage.h"

@implementation DGWikiImage

- (instancetype) initWithJSONDictionary:(NSDictionary *)json {
    if (self = [super initWithJSONDictionary:json]) {
        
        NSArray *imageInfo = [json objectForKey:@"imageinfo"];
        
        
        self.URL = [json objectForKey:@"url"];
    }
    
    return self;
}

@end
