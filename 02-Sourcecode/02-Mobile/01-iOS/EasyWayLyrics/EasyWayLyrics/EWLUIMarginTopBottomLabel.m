//
//  EWLUIMarginTopBottomLabel.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/14/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLUIMarginTopBottomLabel.h"

@implementation EWLUIMarginTopBottomLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {25, 15, 25, 15};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
