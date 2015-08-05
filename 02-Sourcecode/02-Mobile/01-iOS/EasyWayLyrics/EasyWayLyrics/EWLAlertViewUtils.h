//
//  EWLAlertViewUtils.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/1/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWLAlertViewUtils : NSObject

+(UIAlertView*) buildAlertForNoConnectivity;
+(UIAlertView*) buildAlertForErrorRequest;
+(UIAlertView*) buildAlertForSongNotFoundRequest;
+(UIAlertView*) buildAlertForMissingInformation;
+(UIAlertView*) buildAlertForMinCharacters:(int) number;
+(UIAlertView*) buildAlertForInvalidEmail;
+(UIAlertView*) buildAlertForContactSuccess;
+(UIAlertView*) buildAlertForNoSynchronizedLyrics;
+(UIAlertView*) buildAlertForMissingSongInformation;
+(UIAlertView*) buildAlertForNotIdentifiedSong;
+(UIAlertView*) buildAlertForNotIdentifiedSongLibrary;
@end
