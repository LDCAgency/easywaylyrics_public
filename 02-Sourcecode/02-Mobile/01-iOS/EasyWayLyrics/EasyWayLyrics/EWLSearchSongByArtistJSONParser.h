//
//  EWLSearchSongByArtistJSONParser.h
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 4/16/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

//Models
#import "EWLBaseLyricFindResponse.h"
#import "EWLSearchArtistSongLyricWithoutLyricsResponse.h"
#import "EWLSearchArtistSongLyricWithLyricsResponse.h"
#import "EWLSearchArtistSongLyricWithLyricsItem.h"

@interface EWLSearchSongByArtistJSONParser : NSObject

-(EWLBaseLyricFindResponse*) parseSuccessfulResponse:(NSDictionary*)jsonArray;

@end
