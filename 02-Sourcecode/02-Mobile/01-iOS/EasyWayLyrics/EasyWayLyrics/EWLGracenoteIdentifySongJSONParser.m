//
//  EWLEchonestIdentifySongJSONParser.m
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 4/29/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLGracenoteIdentifySongJSONParser.h"

@implementation EWLGracenoteIdentifySongJSONParser

-(EWLGracenoteIdentifySongResponse*) parseSuccessfulResponse:(GNSearchResponse*)result{
  
    EWLGracenoteIdentifySongResponse* response = [[EWLGracenoteIdentifySongResponse alloc] initWithArtist:result.artist AndSong:result.trackTitle AndMatchedPosition:[result.songPosition intValue]] ;
    return response;
}


@end
