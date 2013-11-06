//
//  ViewController.h
//  news-reader
//
//  Created by Dmitry Kamorin on 11/1/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#import "Grabber.h"
#import "NewsItem.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) NSMutableArray *items;
@property (weak, nonatomic) NSArray *news;

@property (weak, nonatomic) IBOutlet UITableView *newsTable;

@end
