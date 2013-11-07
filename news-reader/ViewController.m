//
//  ViewController.m
//  news-reader
//
//  Created by Dmitry Kamorin on 11/1/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#define GENERAL_SIZE_CONST 90

#import "ViewController.h"
#import "Grabber.h"
#import "NewsItem.h"
#import "Cell.h"


@interface ViewController () {
    NSArray *news;
}

@property (weak, nonatomic) IBOutlet UITableView *newsTable;

- (NSString *) convertDate:(NSString *) date;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	news = [Grabber grabNews];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [news count];
}

- (void) downloadImage:(NSURL *)url completitionBlock:(void (^)(BOOL succeded, UIImage *image))completitionBlock {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
        if(!error) {
            UIImage *image = [[UIImage alloc] initWithData:data];
            completitionBlock(YES, image);
        } else {
            completitionBlock(NO, nil);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *cellIdentifier = @"Cell";
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NewsItem *item = [news objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = [self convertDate:item.datetime ];
    cell.textLabel.text =  item.title;
    cell.detailTextLabel.text = item.description;
    
    cell.imageView.image =  [UIImage imageNamed:@"placeholder.png"];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(32,34,0,0)];
    spinner.color = [UIColor grayColor];
    [spinner startAnimating];
    [cell.imageView addSubview:spinner];
    
    [self downloadImage:item.thumbnailUrl completitionBlock:^(BOOL succeded, UIImage *image) {
        if(succeded) {
            cell.imageView.image = image;
            [spinner stopAnimating];
        }
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GENERAL_SIZE_CONST;
}

- (NSString *) convertDate:(NSString *) dateString
{
    
    NSTimeInterval interval = [dateString intValue];
    NSDate *nsDate = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    return [formatter stringFromDate:nsDate];
}

@end
