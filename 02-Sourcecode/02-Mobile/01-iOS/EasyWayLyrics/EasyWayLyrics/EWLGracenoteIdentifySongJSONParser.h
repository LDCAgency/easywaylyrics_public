//
//  EWLEchonestIdentifySongJSONParser.h
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 4/29/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

//Libraries
#import <GracenoteMusicID/GNSearchResponse.h>

//Models
#import "EWLGracenoteIdentifySongResponse.h"


@interface EWLGracenoteIdentifySongJSONParser : NSObject

-(EWLGracenoteIdentifySongResponse*) parseSuccessfulResponse:(GNSearchResponse*)result;

@end
