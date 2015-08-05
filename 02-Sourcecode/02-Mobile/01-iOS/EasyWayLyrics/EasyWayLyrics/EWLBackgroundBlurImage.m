//
//  EWLBackgroundBlurImage.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/10/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLBackgroundBlurImage.h"

@implementation EWLBackgroundBlurImage

+(id) sharedInstance
{
    static EWLBackgroundBlurImage *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EWLBackgroundBlurImage alloc] init];
    });
    return instance;
}

@end
