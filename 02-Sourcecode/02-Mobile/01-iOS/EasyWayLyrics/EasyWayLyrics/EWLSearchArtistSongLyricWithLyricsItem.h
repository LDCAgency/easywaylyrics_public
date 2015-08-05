//
//  EWLSearchArtistSongLyricWithLyricsItem.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/4/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWLSearchArtistSongLyricWithLyricsItem : NSObject

@property (nonatomic) long long duration;
@property (strong,nonatomic) NSString* lrc_timestamp;
@property (strong,nonatomic) NSString* line;
@property (nonatomic) long long milliseconds;

@end
