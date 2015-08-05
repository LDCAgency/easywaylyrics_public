//
//  EWLStringUtils.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/14/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLStringUtils.h"

@implementation EWLStringUtils

#define CLOCK_FORMAT_DEFAULT @"%02d:%02d"

+(NSString *)secondsToClockFormat:(int)seconds
{
    int currentHours = (seconds / 3600);
    int currentMinutes = ((seconds / 60) - currentHours*60);
    int currentSeconds = (seconds % 60);
    
    return [NSString stringWithFormat:CLOCK_FORMAT_DEFAULT, currentMinutes, currentSeconds];
}

+(NSString*) urlEncodeString:(NSString*) unescaped
{
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]\" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedString = [unescaped stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedString;
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end
