//
//  ViewController.m
//  news-reader
//
//  Created by Dmitry Kamorin on 11/1/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#define CELL_HEIGHT 70

#import "ViewController.h"
#import "Grabber.h"
#import "NewsItem.h"


@interface ViewController () {
    NSArray *news;
}

@property (weak, nonatomic) IBOutlet UITableView *newsTable;

@property (weak,nonatomic) NSMutableArray *titles;
@property (weak,nonatomic) NSMutableArray *descriptions;
@property (weak, nonatomic) NSMutableArray *items;

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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.numberOfLines = 1;
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.numberOfLines = 2;
    }
    NewsItem *item = [news objectAtIndex:indexPath.row];
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
    return CELL_HEIGHT;
}



@end
