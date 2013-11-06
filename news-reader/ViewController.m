//
//  ViewController.m
//  news-reader
//
//  Created by Dmitry Kamorin on 11/1/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#define TITLE_FONT_SIZE 20.0f
#define DETAILED_FONT_SIZE 14.0f
#define IMAGE_WIDTH 70
#define MAGIC_CONST 0
#define PADDING 5.0f

#import "ViewController.h"
#import "Cell.h"


@interface ViewController ()

@property (weak,nonatomic) NSMutableArray *titles;
@property (weak,nonatomic) NSMutableArray *descriptions;

@end

@implementation ViewController

@synthesize newsTable;

@synthesize news;
@synthesize items;

@synthesize titles;
@synthesize descriptions;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    news = [Grabber grabNews];
    titles = [NSMutableArray arrayWithCapacity:news.count ];
    descriptions = [NSMutableArray arrayWithCapacity:news.count ];
    int index = 0;
    for(NewsItem *item in news) {
        [self calculateHeightForText:item.title DetailedText:item.description Index:index];
        index++;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
//    return [items count];
    return [news count];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell = [[Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILED_FONT_SIZE];
//        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
//        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedBackground.png"]];
//        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    NewsItem *item = [news objectAtIndex:indexPath.row];
    cell.textLabel.text =  item.title; //[NSString stringWithFormat:@"Simple and very-very long text %i", indexPath.row];
    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.detailTextLabel.text = item.description; //[NSString stringWithFormat:@"detail text %i", indexPath.row];
    cell.imageView.image =  [self makeThumbnailFor:[UIImage imageNamed:@"placeholder.png"] OfSize:CGSizeMake(IMAGE_WIDTH, IMAGE_WIDTH)];
    

    [self downloadImage:item.thumbnailUrl completitionBlock:^(BOOL succeded, UIImage *image) {
        if(succeded) {
            cell.imageView.image = [self makeThumbnailFor:image OfSize:CGSizeMake(IMAGE_WIDTH, IMAGE_WIDTH)];
        }
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSNumber *flt = [NSNumber numberWithFloat:10.0f];
//    NSString *str = [self.items objectAtIndex:indexPath.row];
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
//    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(self.newsTable.frame.size.width , 1000.f) lineBreakMode:NSLineBreakByWordWrapping];
//    NewsItem *item = [news objectAtIndex:indexPath.row];
//    size[indexPath.row] = [NSNumber numberWithFloat:[item.title sizeWithFont:item.title.font forWidth:cell.frame.origin.x lineBreakMode:NSLineBreakByWordWrapping].height];
//
    if(titles.count > 0 ) {
        float hgt = [titles[indexPath.row] floatValue] + [descriptions[indexPath.row] floatValue];
        if(hgt > IMAGE_WIDTH) {
            NSLog(@"%f", hgt);
            return hgt;
        }
        return IMAGE_WIDTH;
    } else {
        return IMAGE_WIDTH;
    }
}

- (UIImage*) makeThumbnailFor:(UIImage*)image OfSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    // draw scaled image into thumbnail context
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();
    // pop the context
    UIGraphicsEndImageContext();
    if(newThumbnail == nil)
        NSLog(@"could not scale image");
    return newThumbnail;
}

- (void) calculateHeightForText: (NSString*)text DetailedText:(NSString*)detailedText Index:(int)index
{
    titles[index] = [NSNumber numberWithFloat:[text sizeWithFont:[UIFont systemFontOfSize:TITLE_FONT_SIZE] constrainedToSize:CGSizeMake(self.newsTable.frame.size.width - (IMAGE_WIDTH+MAGIC_CONST), 1000.f) lineBreakMode:NSLineBreakByWordWrapping].height];
    descriptions[index] = [NSNumber numberWithFloat:[detailedText sizeWithFont:[UIFont systemFontOfSize:DETAILED_FONT_SIZE] constrainedToSize:CGSizeMake(self.newsTable.frame.size.width - (IMAGE_WIDTH+MAGIC_CONST), 1000.f) lineBreakMode:NSLineBreakByWordWrapping].height];
}


@end
