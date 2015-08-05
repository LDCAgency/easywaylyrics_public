//
//  EWLListeningModalViewControllerDelegate.h
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 5/1/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>
//Models
#import "EWLBaseLyricFindResponse.h"
#import "EWLGracenoteIdentifySongResponse.h"

@protocol EWLListeningModalViewControllerDelegate <NSObject>

-(void) successfulOnListeningDataRetrieval:(EWLGracenoteIdentifySongResponse*)identifySongResponse AndBaseLyricFindResponse:(EWLBaseLyricFindResponse*) baseResponse AndAlbumArtworkImage:(UIImage*) itunesAlbumArtworkImage AndDateStartedSync:(NSDate*) dateStartedSync;
-(void) cancelOnListening;
-(void) errorOnListeningDataRetrieval;
@end
