//
//  EWLConstants.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/3/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWLConstants : NSObject

+(NSString*) SEARCH_LYRICS_SERVICE:(NSString*) artist AndSong:(NSString*)song AndToLang:(NSString*) lang;

+(NSString*) CONTACT_INSERT_SERVICE;

+(NSString*) TEXT_SHARE;

+(NSArray*) TWO_LETTERS_COUNTRIES;
+(NSArray*) COUNTRY_NAMES;

@end
