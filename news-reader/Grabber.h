//
//  Grabber.h
//  news-reader
//
//  Created by Dmitry Kamorin on 11/1/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsItem;

@interface Grabber : NSObject

+ (NSArray *) grabNews; //TODO do it async
@end
