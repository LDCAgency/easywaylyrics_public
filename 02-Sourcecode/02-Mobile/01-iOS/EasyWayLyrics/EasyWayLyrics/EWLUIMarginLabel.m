//
//  EWLUIMarginLabel.m
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 5/5/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLUIMarginLabel.h"

@implementation EWLUIMarginLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {25, 25, 25, 25};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
