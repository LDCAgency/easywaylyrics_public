//
//  EWLSearchArtistSongLyricWithLyricsItem.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/4/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLSearchArtistSongLyricWithLyricsItem.h"

@implementation EWLSearchArtistSongLyricWithLyricsItem

-(NSString *)description{
    return [NSString stringWithFormat:@"[line: %@ milliseconds: %lld]",self.line,self.milliseconds];
}
@end
