//
//  UILabel+UtilityAttributes.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/2/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "UILabel+UtilityAttributes.h"

@implementation UILabel (UtilityAttributes)

- (void) boldRange: (NSRange) range {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    NSMutableAttributedString *attributedText= nil;
    
    if(self.attributedText)
    {
        attributedText = [self.attributedText mutableCopy];
        [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:self.font.pointSize] range:range];
    }
    else
    {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text] ;
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font.pointSize]} range:range];
        
        
    }
    self.attributedText = attributedText;
}

- (void) boldSubstring: (NSString*) substring {
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range];
}

- (void) colorRange: (NSRange) range AndColor:(UIColor*) color {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    NSMutableAttributedString *attributedText= nil;
    
    if(self.attributedText)
    {
        attributedText = [self.attributedText mutableCopy];
        [attributedText addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    else
    {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text] ;
        [attributedText setAttributes:@{NSForegroundColorAttributeName:color} range:range];
        
        
    }
    self.attributedText = attributedText;
}

- (void) colorSubstring: (NSString*) substring AndColor:(UIColor*) color {
    NSRange range = [self.text rangeOfString:substring];
    [self colorRange:range AndColor:color];
}

- (void) increaseFontSizeRange: (NSRange) range AndSize:(CGFloat) size {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    NSMutableAttributedString *attributedText= nil;
    
    if(self.attributedText)
    {
        attributedText = [self.attributedText mutableCopy];
        
        UIFont *font = [self.font fontWithSize:self.font.pointSize + size];
        [attributedText addAttribute:NSFontAttributeName value:font range:range];
    }
    else
    {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text] ;
        UIFont *font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize + size ];
        [attributedText setAttributes:@{NSFontAttributeName:font} range:range];
    }
    self.attributedText = attributedText;
}

- (void) increaseFontSizeSubstring: (NSString*) substring AndSize:(CGFloat) size {
    NSRange range = [self.text rangeOfString:substring];
    [self increaseFontSizeRange:range AndSize:size];
}


- (void) decreaseFontSizeRange: (NSRange) range AndSize:(CGFloat) size {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    NSMutableAttributedString *attributedText= nil;
    
    if(self.attributedText)
    {
        attributedText = [self.attributedText mutableCopy];
        
        UIFont *font = [self.font fontWithSize:self.font.pointSize - size];
        [attributedText addAttribute:NSFontAttributeName value:font range:range];
    }
    else
    {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text] ;
        UIFont *font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize + size ];
        [attributedText setAttributes:@{NSFontAttributeName:font} range:range];
    }
    self.attributedText = attributedText;
}

- (void) decreaseFontSizeSubstring: (NSString*) substring AndSize:(CGFloat) size {
    NSRange range = [self.text rangeOfString:substring];
    [self decreaseFontSizeRange:range AndSize:size];
}

@end
