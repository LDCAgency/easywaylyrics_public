//
//  EWLItunesArtworkRequest.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/15/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLItunesArtworkRequest.h"

@implementation EWLItunesArtworkRequest

-(void) startGetRequest
{
    if(![NetworkAvailabilityUtils isConnected]){
        
        [self.delegate noConnectivity];
        
        return;
        
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[self url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
    
    [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error)
         {
             [self.delegate errorOnRequest:[self identifier]];
             
         }
         else
         {
             if([data length]>0)
             {
                 NSError *error = nil;
                 NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 
                 if (error != nil) {
                     [self.delegate errorOnRequest:[self identifier]];
                 }
                 else {
                         [self.delegate sucessOnRequest:jsonArray AndIdentifier:[self identifier]];
                 }
             }
             else
             {
                 [self.delegate errorOnRequest:[self identifier]];
             }
             
         }
         
         
     }];
    
}

@end
