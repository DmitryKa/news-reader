//
//  Cell.m
//  news-reader
//
//  Created by Dmitry Kamorin on 11/6/13.
//  Copyright (c) 2013 AlDigit. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) layoutSubviews {
    //have the cell layout normally
    [super layoutSubviews];
//    //get the bounding rectangle that defines the position and size of the image
//    CGRect imgFrame = [[self imageView] frame];
////    NSLog(@"imageView bounds h: %f, imageView bounds w: %f",[[self imageView] bounds].size.height,[[self imageView] bounds].size.width);
////    NSLog(@"self bounds h: %f, self bounds w: %f",[self bounds].size.height,[self bounds].size.width);
//    //anchor it to the top-left corner
////    imgFrame.origin.x = 0;
//    imgFrame.origin = CGPointZero;
//    //change the height to be the height of the cell
//    imgFrame.size.height = [self frame].size.height;
//    //change the width to be the same as the height
//    imgFrame.size.width = imgFrame.size.height;
//    //set the imageView's frame (this will move+resize it)
//    [[self imageView] setFrame:imgFrame];
    
    //reposition the other labels accordingly
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
