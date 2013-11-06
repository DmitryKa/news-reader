//
//  news_item.h
//  news-reader
//
//  Created by Dmitry Kamorin on 11/1/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *description;
@property (weak, nonatomic) NSString *datetime;
@property (weak, nonatomic) NSString *article;
@property (retain, nonatomic) NSURL *thumbnailUrl;

- (id) init: (NSDictionary*) fields;
@end
