//
//  news_item.m
//  news-reader
//
//  Created by Dmitry Kamorin on 11/1/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

- (id) init: (NSDictionary*) fields {
    _title = [fields objectForKey:@"title"];
    _description = [fields objectForKey:@"description"];
    _datetime = [fields objectForKey:@"datetime"];
    _article = [fields objectForKey:@"article"];
    NSURL *url = [NSURL URLWithString:[fields objectForKey:@"thumbnail"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _thumbnailUrl = url;
    return self;
}

@end
