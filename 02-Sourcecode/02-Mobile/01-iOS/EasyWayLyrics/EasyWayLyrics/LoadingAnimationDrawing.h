//
//  LoadingAnimationDrawing.h
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 5/19/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingAnimationDrawing : UIView

@property (nonatomic) int showLevel;

-(void) showNextLevel;
-(void) clearLevel;

@end
