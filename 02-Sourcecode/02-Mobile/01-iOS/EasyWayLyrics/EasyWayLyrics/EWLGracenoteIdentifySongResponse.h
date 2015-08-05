//
//  EWLGracenoteIdentifySongResponse.h
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 4/29/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLBaseResponse.h"

@interface EWLGracenoteIdentifySongResponse : EWLBaseResponse

@property(nonatomic,strong) NSString* artist;
@property(nonatomic,strong) NSString* song;
@property(nonatomic) int matchedPosition;

-(instancetype) initWithArtist:(NSString*) artist AndSong:(NSString*) song;
-(instancetype) initWithArtist:(NSString*) artist AndSong:(NSString*) song AndMatchedPosition:(int) matchedPosition;

@end
