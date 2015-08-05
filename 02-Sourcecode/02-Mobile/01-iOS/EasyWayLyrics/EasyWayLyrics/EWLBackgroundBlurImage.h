//
//  EWLBackgroundBlurImage.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/10/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWLBackgroundBlurImage : NSObject

+(id) sharedInstance;

@property(nonatomic,strong) UIImage* albumBlurBackground;

@end
