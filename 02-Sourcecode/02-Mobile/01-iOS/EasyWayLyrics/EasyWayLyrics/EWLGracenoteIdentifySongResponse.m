//
//  EWLGracenoteIdentifySongResponse.m
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 4/29/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLGracenoteIdentifySongResponse.h"

@implementation EWLGracenoteIdentifySongResponse

-(instancetype) initWithArtist:(NSString*) artist AndSong:(NSString*) song{
    self = [super init];
    if(self){
        self.artist = artist;
        self.song = song;
    }
    return self;
}

-(instancetype) initWithArtist:(NSString*) artist AndSong:(NSString*) song AndMatchedPosition:(int) matchedPosition{
    self = [self initWithArtist:artist AndSong:song];
    if(self){
        self.matchedPosition = matchedPosition;
    }
    return self;
}

@end
