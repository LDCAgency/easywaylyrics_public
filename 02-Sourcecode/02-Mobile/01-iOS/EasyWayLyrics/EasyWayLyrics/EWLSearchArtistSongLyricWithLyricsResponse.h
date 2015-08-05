//
//  EWLSearchArtistSongLyricWithLyricsResponse.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/4/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EWLBaseLyricFindResponse.h"

@interface EWLSearchArtistSongLyricWithLyricsResponse : EWLBaseLyricFindResponse

@property (strong,nonatomic) NSArray* lrc; //Of EWLSearchArtistSongLyricWithLyricsItem
@end
