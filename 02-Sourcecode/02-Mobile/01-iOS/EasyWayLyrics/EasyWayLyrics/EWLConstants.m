//
//  EWLConstants.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/3/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLConstants.h"

@implementation EWLConstants

+(NSString*) HOST{
    static NSString* baseUrl;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *env = [[NSProcessInfo processInfo] environment];
        NSString *overrideBaseUrl = [env valueForKey:@"BASE_URL"];
        if(overrideBaseUrl && ![overrideBaseUrl isEqualToString:@""]){
            baseUrl = overrideBaseUrl;
        }else{
            NSLog(@"%s BASE_URL ENVIRONMENTAL VARIABLES ISN'T SET",__PRETTY_FUNCTION__);
            baseUrl = @"http://<your-wen-host>/";
        }
    });
    return baseUrl;
}

+(NSArray*) TWO_LETTERS_COUNTRIES{
    static NSArray* array ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[@"af",@"sq",@"ar",@"az",@"eu",@"be",@"bg",@"ca",@"zh-CN",@"hr",@"cs",@"da",@"nl",@"en",@"eo",@"et",@"tl",@"fi",@"fr",@"gl",@"ka",@"de",@"el",@"gu",@"ht",@"iw",@"hi",@"hu",@"is",@"id",@"ga",@"it",@"ja",@"kn",@"ko",@"la",@"lv",@"lt",@"mk",@"ms",@"mt",@"no",@"fa",@"pl",@"pt",@"ro",@"ru",@"sr",@"sk",@"sl",@"es",@"sw",@"sv",@"ta",@"te",@"th",@"tr",@"uk",@"ur",@"vi",@"cy",@"yi"];
    });
    return array;
}

+(NSArray*) COUNTRY_NAMES{
    static NSArray* array ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[ @"Afrikaans",@"Albanian",@"Arabic",@"Azerbaijani",@"Basque",@"Belarusian",@"Bulgarian",@"Catalan",@"Chinese",@"Croatian",@"Czech",@"Danish",@"Dutch",@"English",@"Esperanto",@"Estonian",@"Filipino",@"Finnish",@"French",@"Galician",@"Georgian",@"German",@"Greek",@"Gujarati",@"Haitian",@"Hebrew",@"Hindi",@"Hungarian",@"Icelandic",@"Indonesian",@"Irish",@"Italian",@"Japanese",@"Kannada",@"Korean",@"Latin",@"Latvian",@"Lithuanian",@"Macedonian",@"Malay",@"Maltese",@"Norwegian",@"Persian",@"Polish",@"Portuguese",@"Romanian",@"Russian",@"Serbian",@"Slovak",@"Slovenian",@"Spanish",@"Swahili",@"Swedish",@"Tamil",@"Telugu",@"Thai",@"Turkish",@"Ukrainian",@"Urdu",@"Vietnamese",@"Welsh",@"Yiddish"];
    });
    return array;
}

+(NSString*) SEARCH_LYRICS_SERVICE:(NSString*) artist AndSong:(NSString*)song AndToLang:(NSString*) lang
{
    return [ [EWLConstants HOST] stringByAppendingString:[NSString stringWithFormat:@"lyricfind/search/%@/%@/%@",[EWLStringUtils urlEncodeString:artist],[EWLStringUtils urlEncodeString:song],[EWLStringUtils urlEncodeString:lang]]];
}

+(NSString*) CONTACT_INSERT_SERVICE
{
    return [[EWLConstants HOST] stringByAppendingString:@"contact/bookprivatelesson/"];
}

+(NSString*) TEXT_SHARE
{
    return @"Easy Way Lyrics (iPhone app) www.easywaylyrics.com";
}

@end
