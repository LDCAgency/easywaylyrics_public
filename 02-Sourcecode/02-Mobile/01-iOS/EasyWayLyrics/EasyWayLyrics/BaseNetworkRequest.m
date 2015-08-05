//
//  BaseNetworkRequest.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/3/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "BaseNetworkRequest.h"


@implementation BaseNetworkRequest

-(void) startGetRequest
{
    if(![NetworkAvailabilityUtils isConnected]){
        
        [self.delegate noConnectivity];
        
        return;
        
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[self url]];
    
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
#ifdef DEBUG
                 NSLog(@"%s Returned from Server : Data: %@",__PRETTY_FUNCTION__, [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
#endif
                 NSError *error = nil;
                 NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 
                 if (error != nil) {
                     [self.delegate errorOnRequest:[self identifier]];
                 }
                 else {
                     NSNumber *code = [jsonArray objectForKey:@"code"];
                     if([code intValue] >= 0)
                     {
                        #ifdef DEBUG
                            NSLog(@"%s Array: %@",__PRETTY_FUNCTION__, jsonArray);
                        #endif
                         
                         [self.delegate sucessOnRequest:jsonArray AndIdentifier:[self identifier]];
                     }
                     else if ([code intValue] >= -2)
                     {
                         [self.delegate errorOnRequest:[self identifier] AndResponseCode:[code intValue]];
                     }
                     else
                     {
                         [self.delegate errorOnRequest:[self identifier]];
                     }
                     
                 }
                 
                 
             }
             else
             {
                 [self.delegate errorOnRequest:[self identifier]];
             }
             
         }
         
         
     }];
    
}

-(void) startPostRequest:(NSData *)postBody
{
    if(![NetworkAvailabilityUtils isConnected]){
        
        [self.delegate noConnectivity];
        
        return;
        
    }
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[self url]];
    
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [postRequest setValue:[NSString
                           stringWithFormat:@"%lu", (unsigned long)[postBody length]]
       forHTTPHeaderField:@"Content-length"];
    
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:postBody];
    
    
    [NSURLConnection sendAsynchronousRequest:postRequest queue: [NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error)
         {
             [self.delegate errorOnRequest:[self identifier]];
             
         }
         else
         {
             if([data length]>0)
             {
                #ifdef DEBUG
                 NSLog(@"%s Returned from Server : Data: %@",__PRETTY_FUNCTION__, [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                #endif
                 NSError *error = nil;
                 NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 
                 if (error != nil) {
                     [self.delegate errorOnRequest:[self identifier]];
                 }
                 else {
                     NSNumber *code = [jsonArray objectForKey:@"code"];
                     if([code intValue] >= 0)
                     {
#ifdef DEBUG
                         NSLog(@"%s Array: %@",__PRETTY_FUNCTION__, jsonArray);
#endif
                         [self.delegate sucessOnRequest:jsonArray AndIdentifier:[self identifier]];
                     }
                     else if ([code intValue] >= -2)
                     {
                         [self.delegate errorOnRequest:[self identifier] AndResponseCode:[code intValue]];
                     }
                     else
                     {
                         [self.delegate errorOnRequest:[self identifier]];
                     }
                     
                 }
             }
             else
             {
                 [self.delegate errorOnRequest:[self identifier]];
             }
             
         }
     }];
}

-(void) startPostMultipartDataRequest:(NSDictionary *)postParameters
{
    if(![NetworkAvailabilityUtils isConnected]){
        
        [self.delegate noConnectivity];
        
        return;
        
    }
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[self url]];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    [postRequest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *postbody = [NSMutableData data];
    
    
    NSEnumerator *enumerator = [postParameters keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        NSObject *tmp = [postParameters objectForKey:key];
        
        if([tmp isKindOfClass:[NSData class]]){
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.caf\"\r\n", key,key] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [postbody appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[NSData dataWithData:[postParameters objectForKey:key]]];
            [postbody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }else{
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"%@\r\n", [postParameters objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    [postbody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:postbody];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", (int)[postbody length]];
    [postRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    [NSURLConnection sendAsynchronousRequest:postRequest queue: [NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error)
         {
             [self.delegate errorOnRequest:[self identifier]];
             
         }
         else
         {
             if([data length]>0)
             {
#ifdef DEBUG
                 NSLog(@"%s Returned from Server : Data: %@",__PRETTY_FUNCTION__, [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
#endif
                 NSError *error = nil;
                 NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 
                 if (error != nil) {
                     [self.delegate errorOnRequest:[self identifier]];
                 }
                 else {
                     NSNumber *code = [jsonArray objectForKey:@"code"];
                     if([code intValue] >= 0)
                     {
#ifdef DEBUG
                         NSLog(@"%s Array: %@",__PRETTY_FUNCTION__, jsonArray);
#endif
                         [self.delegate sucessOnRequest:jsonArray AndIdentifier:[self identifier]];
                     }
                     else if ([code intValue] >= -2)
                     {
                         [self.delegate errorOnRequest:[self identifier] AndResponseCode:[code intValue]];
                     }
                     else
                     {
                         [self.delegate errorOnRequest:[self identifier]];
                     }
                     
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