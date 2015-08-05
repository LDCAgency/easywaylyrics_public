//
//  UILabel+UtilityAttributes.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/2/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UtilityAttributes)

- (void) boldSubstring: (NSString*) substring;
- (void) boldRange: (NSRange) range;

- (void) colorRange: (NSRange) range AndColor:(UIColor*) color;
- (void) colorSubstring: (NSString*) substring AndColor:(UIColor*) color;

- (void) increaseFontSizeRange: (NSRange) range AndSize:(CGFloat) size;
- (void) increaseFontSizeSubstring: (NSString*) substring AndSize:(CGFloat) size ;

- (void) decreaseFontSizeRange: (NSRange) range AndSize:(CGFloat) size;
- (void) decreaseFontSizeSubstring: (NSString*) substring AndSize:(CGFloat) size;

@end
