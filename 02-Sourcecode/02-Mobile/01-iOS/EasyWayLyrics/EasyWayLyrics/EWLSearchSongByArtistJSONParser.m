//
//  EWLSearchSongByArtistJSONParser.m
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 4/16/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLSearchSongByArtistJSONParser.h"

@implementation EWLSearchSongByArtistJSONParser

-(EWLBaseLyricFindResponse*) parseSuccessfulResponse:(NSDictionary*)jsonArray{
    EWLBaseLyricFindResponse* baseResponse ;
    
    NSNumber *code = [jsonArray objectForKey:@"code"];
    if([code intValue] == 0)
    {
        baseResponse = [[EWLSearchArtistSongLyricWithLyricsResponse alloc] init];
        baseResponse.code = [code intValue];
        
        NSArray *jsonLrcArray = [jsonArray objectForKey:@"lrc"];
        NSMutableArray* lrcArray = [[NSMutableArray alloc] init];
        
        for(int i=0; i < [jsonLrcArray count]; i++)
        {
            NSDictionary* lrcObj = [jsonLrcArray objectAtIndex:i];
            
            EWLSearchArtistSongLyricWithLyricsItem *lrcItem = [[EWLSearchArtistSongLyricWithLyricsItem alloc] init];
            
            if([lrcObj objectForKey:@"duration"] != nil)
                lrcItem.duration = [[lrcObj objectForKey:@"duration"] longLongValue];
            
            if([lrcObj objectForKey:@"milliseconds"] != nil)
                lrcItem.milliseconds = [[lrcObj objectForKey:@"milliseconds"] longLongValue];
            
            if([lrcObj objectForKey:@"lrc_timestamp"] != nil)
                lrcItem.lrc_timestamp = [lrcObj objectForKey:@"lrc_timestamp"];
            
            if([lrcObj objectForKey:@"line"] != nil)
                lrcItem.line = [lrcObj objectForKey:@"line"];
            
            if(![lrcItem.line isEqualToString:@""]){
                [lrcArray addObject:lrcItem];
            }
        }
        
        ((EWLSearchArtistSongLyricWithLyricsResponse*)baseResponse).lrc = lrcArray;
    }
    else if([code intValue] == 1)
    {
        baseResponse = [[EWLSearchArtistSongLyricWithoutLyricsResponse alloc] init];
        baseResponse.code = [code intValue];
        ((EWLSearchArtistSongLyricWithoutLyricsResponse*)baseResponse).lyrics = [jsonArray objectForKey:@"lyrics"];
        ((EWLSearchArtistSongLyricWithoutLyricsResponse*)baseResponse).original = [jsonArray objectForKey:@"original"];
    }
    //Getting common attributtes for songs with/without lyrics
    baseResponse.copyright = [jsonArray objectForKey:@"copyright"];
    baseResponse.writer = [jsonArray objectForKey:@"writer"];
    baseResponse.predominant_language = [jsonArray objectForKey:@"predominant_language"];
    baseResponse.translated_to_lang = [jsonArray objectForKey:@"translated_to_lang"];

    //Adding Copyright and Writer
    //[self addLegalStuff:baseResponse];

    return baseResponse;
}

//-(void) addLegalStuff:(EWLBaseLyricFindResponse*) baseResponse{
//    NSString *copyrightAndRightString = [NSString stringWithFormat:@"Copyright: %@\r\n Writer: %@",baseResponse.copyright,baseResponse.writer];
//    if ([baseResponse isKindOfClass:[EWLSearchArtistSongLyricWithLyricsResponse class]]) {
//        //Adding Element to lrc array
//        NSMutableArray* lrcArray = [((EWLSearchArtistSongLyricWithLyricsResponse*)baseResponse).lrc mutableCopy];
//        EWLSearchArtistSongLyricWithLyricsItem *lrcCopyRightAndWriter = [[EWLSearchArtistSongLyricWithLyricsItem alloc] init];
//        lrcCopyRightAndWriter.line = copyrightAndRightString;
//        lrcCopyRightAndWriter.lrc_timestamp = [NSString stringWithFormat:@"%d",[((EWLSearchArtistSongLyricWithLyricsItem*)[((EWLSearchArtistSongLyricWithLyricsResponse*)baseResponse).lrc lastObject]).lrc_timestamp intValue] + 2000];
//        [lrcArray addObject:lrcCopyRightAndWriter];
//        ((EWLSearchArtistSongLyricWithLyricsResponse*)baseResponse).lrc = lrcArray;
//    }else if([baseResponse isKindOfClass:[EWLSearchArtistSongLyricWithoutLyricsResponse class]]){
//        ((EWLSearchArtistSongLyricWithoutLyricsResponse*)baseResponse).lyrics = [NSString stringWithFormat:@"%@\r\n%@",((EWLSearchArtistSongLyricWithoutLyricsResponse*)baseResponse).lyrics, copyrightAndRightString];
//    }
//}

@end
