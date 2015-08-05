//
//  EWLDateUtils.h
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 5/1/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWLDateUtils : NSObject

+(NSString*) timeElapsedBetweenDateFrom:(NSString*) dateFrom AndDateTo:(NSString*) dateTo AndFormat:(NSString*) format;

+(NSString*) timeElapsedLongFormatBetweenDateFrom:(NSString*) dateFrom AndDateTo:(NSString*) dateTo AndFormat:(NSString*) format;

+(NSString*) timeElapsedBetweenDateFrom:(NSDate*) dateFrom AndDateTo:(NSDate*) dateTo;

+(NSString*) timeElapsedLongFormatBetweenDateFrom:(NSDate*) dateFrom AndDateTo:(NSDate*) dateTo;

+(long) secondsBetweenDateFrom:(NSDate*) dateFrom AndDateTo:(NSDate*) dateTo;

+(NSDate*) convertToDate:(NSString*) date WithFormat:(NSString*) format;

+(NSString*) convertToString:(NSDate*) date WithFormat:(NSString*) format;

+(NSDate*) convertDateInUTC:(NSDate*)date;

@end
