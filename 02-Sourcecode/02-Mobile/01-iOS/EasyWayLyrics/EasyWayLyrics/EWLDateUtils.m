//
//  EWLDateUtils.m
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 5/1/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLDateUtils.h"

@implementation EWLDateUtils

+(NSString*) timeElapsedBetweenDateFrom:(NSString*) dateFrom AndDateTo:(NSString*) dateTo AndFormat:(NSString*) format
{
    NSDate* dateFromDt;
    NSDate* dateToDt;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    dateFromDt = [dateFormatter dateFromString:dateFrom];
    dateToDt = [dateFormatter dateFromString:dateTo];
    
    
    return [EWLDateUtils timeElapsedBetweenDateFrom:dateFromDt AndDateTo:dateToDt];
}

+(NSString*) timeElapsedLongFormatBetweenDateFrom:(NSString*) dateFrom AndDateTo:(NSString*) dateTo AndFormat:(NSString*) format
{
    NSDate* dateFromDt;
    NSDate* dateToDt;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    dateFromDt = [dateFormatter dateFromString:dateFrom];
    dateToDt = [dateFormatter dateFromString:dateTo];
    
    
    return [EWLDateUtils timeElapsedLongFormatBetweenDateFrom:dateFromDt AndDateTo:dateToDt];
}

+(NSString*) timeElapsedBetweenDateFrom:(NSDate*) dateFrom AndDateTo:(NSDate*) dateTo
{
    NSString* strRet ;
    long diff = (long)[dateTo timeIntervalSinceDate:dateFrom];
    
    long diffSeconds = diff / 60;
    long diffMinutes = diff / 60 % 60;
    long diffHours = diff / (60 * 60 ) % 24;
    long diffDays = diff / (24 * 60 * 60 );
    long diffWeeks = diff / (24 * 60 * 60 * 7);
    
    if((diffSeconds <= 59 && diffMinutes == 0 && diffHours == 0 && diffDays==0) || ( diffSeconds <= 59 && diffMinutes <= 1 && diffHours == 0 && diffDays==0) ){
        //1 min
        strRet = [NSString stringWithFormat:@"%dm",1];
    }else if (diffMinutes <= 59 && diffHours == 0 && diffDays==0){
        //x min
        strRet = [NSString stringWithFormat:@"%ldm",diffMinutes];
    }else if (diffHours <= 24  && diffDays==0){
        //x hours
        strRet = [NSString stringWithFormat:@"%ldh",diffHours];
    }else if (diffDays<=6 && diffWeeks ==0){
        //x days
        strRet = [NSString stringWithFormat:@"%ldd",diffDays];
    }else{
        //x weeks
        strRet = [NSString stringWithFormat:@"%ldw",diffWeeks];
    }
    
    return strRet;
}

+(NSString*) timeElapsedLongFormatBetweenDateFrom:(NSDate*) dateFrom AndDateTo:(NSDate*) dateTo
{
    NSString* strRet ;
    long diff = (long)[dateTo timeIntervalSinceDate:dateFrom];
    
    long diffSeconds = diff / 60;
    long diffMinutes = diff / 60 % 60;
    long diffHours = diff / (60 * 60 ) % 24;
    long diffDays = diff / (24 * 60 * 60 );
    long diffWeeks = diff / (24 * 60 * 60 * 7);
    
    if(diffSeconds <= 0 && diffMinutes == 0 && diffHours == 0 && diffDays==0){
        strRet = [NSString stringWithFormat:@"%d min",0];
    }else if((diffSeconds <= 59 && diffMinutes == 0 && diffHours == 0 && diffDays==0) || ( diffSeconds <= 59 && diffMinutes <= 1 && diffHours == 0 && diffDays==0) ){
        //1 min
        strRet = [NSString stringWithFormat:@"%d min",1];
    }else if (diffMinutes <= 59 && diffHours == 0 && diffDays==0){
        //x min
        strRet = [NSString stringWithFormat:@"%ld mins",diffMinutes];
    }else if (diffHours == 1  && diffDays==0){
        //x hour
        strRet = [NSString stringWithFormat:@"%ld hour",diffHours];
    }else if (diffHours <= 24  && diffDays==0){
        //x hours
        strRet = [NSString stringWithFormat:@"%ld hours",diffHours];
    }else if (diffDays ==1 && diffWeeks ==0){
        //x days
        strRet = [NSString stringWithFormat:@"%ld day",diffDays];
    }else if (diffDays<=6 && diffWeeks ==0){
        //x days
        strRet = [NSString stringWithFormat:@"%ld days",diffDays];
    }else if (diffWeeks ==1){
        //x days
        strRet = [NSString stringWithFormat:@"%ld week",diffWeeks];
    }else{
        //x weeks
        strRet = [NSString stringWithFormat:@"%ld weeks",diffWeeks];
    }
    
    return strRet;
}

+(long) secondsBetweenDateFrom:(NSDate*) dateFrom AndDateTo:(NSDate*) dateTo
{
    long diff = (long)[dateTo timeIntervalSinceDate:dateFrom];
    long diffMinutes = diff / 60;
    return diffMinutes;
}

+(NSDate*) convertToDate:(NSString*) date WithFormat:(NSString*) format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:date];
}

+(NSString*) convertToString:(NSDate*) date WithFormat:(NSString*) format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

+(NSDate*) convertDateInUTC:(NSDate*)date{
    NSDateFormatter *utc = [[NSDateFormatter alloc] init];
    [utc setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [utc setDateFormat:@"dd/MM/yyyy HH:mm:ss Z"];
    NSDate *dtUTC = [utc dateFromString:[EWLDateUtils convertToString:date WithFormat:@"dd/MM/yyyy HH:mm:ss Z"]];
    
    return dtUTC;
}

@end
