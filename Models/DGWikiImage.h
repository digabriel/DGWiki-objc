//
//  DGWikiImage.h
//  Wikipedia
//
//  Created by Dimas Gabriel on 8/31/14.
//  Copyright (c) 2014 Dimas Gabriel. All rights reserved.
//

#import "DGWikiBaseModel.h"

@interface DGWikiImage : DGWikiBaseModel

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSString *title;

- (instancetype) initWithJSONDictionary:(NSDictionary *)json;

@end
