//
//  Cell.m
//  news-reader
//
//  Created by Dmitry Kamorin on 11/7/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#import "Cell.h"

#define DATE_FONT_SIZE 13.0f
#define PADDING 5.0f

@implementation Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:DATE_FONT_SIZE];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = [UIColor lightGrayColor];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.numberOfLines = 1;
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.numberOfLines = 2;
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect oldFrame = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y-(DATE_FONT_SIZE+PADDING)/2, oldFrame.size.width, oldFrame.size.height);
    
    oldFrame = self.detailTextLabel.frame;
    self.detailTextLabel.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y-(DATE_FONT_SIZE+PADDING)/2, oldFrame.size.width, oldFrame.size.height);
    
    CGSize size = self.frame.size;
    _dateLabel.frame = CGRectMake(0, size.height-DATE_FONT_SIZE-PADDING, size.width-3*PADDING, DATE_FONT_SIZE);
    
    [self.contentView addSubview:_dateLabel];
}

@end
