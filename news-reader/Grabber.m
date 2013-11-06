//
//  Grabber.m
//  news-reader
//
//  Created by Dmitry Kamorin on 11/1/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#import "Grabber.h"
#import "NewsItem.h"

@implementation Grabber

+ (NSArray *) grabNews {
    NSArray *newsAr = [NSArray arrayWithObjects: [[NewsItem alloc] init:@{
                                                  @"title": @"It's a very-very-very-very-very-very-very-very long first title",
                                                  @"description": @"It's a some description",
                                                  @"datetime": @"1383238836",
                                                  @"article": @"article.html",
                                                  @"thumbnail": @"https://lh6.googleusercontent.com/-AjFSmpx0his/UnM8tGDun_I/AAAAAAAAAEk/OrFd_v5GNjQ/smile.jpg"
                                                  }],
                       [[NewsItem alloc] init:@{
                        @"title": @"Another title",
                        @"description": @"Second description",
                        @"datetime": @"1383238837",
                        @"article": @"article2.html",
                        @"thumbnail": @"http://i185.photobucket.com/albums/x304/metalife/transmetropolitan-smile.png"
                        }],
                       nil];
    return newsAr;
}

@end
