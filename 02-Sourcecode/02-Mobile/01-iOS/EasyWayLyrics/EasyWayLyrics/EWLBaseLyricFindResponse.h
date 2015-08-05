//
//  EWLBaseLyricFindResponse.h
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 4/16/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLBaseResponse.h"

@interface EWLBaseLyricFindResponse : EWLBaseResponse

@property(nonatomic,strong) NSString* copyright;
@property(nonatomic,strong) NSString* writer;
@property(nonatomic,strong) NSString* predominant_language;
@property(nonatomic,strong) NSString* translated_to_lang;

@end
