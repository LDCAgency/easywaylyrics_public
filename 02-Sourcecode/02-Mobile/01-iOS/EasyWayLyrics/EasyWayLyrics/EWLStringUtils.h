//
//  EWLStringUtils.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/14/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWLStringUtils : NSObject

+(NSString*) secondsToClockFormat:(int) seconds;
+(NSString*) urlEncodeString:(NSString*) unescaped;
+ (BOOL) validateEmail: (NSString *) candidate;
@end
