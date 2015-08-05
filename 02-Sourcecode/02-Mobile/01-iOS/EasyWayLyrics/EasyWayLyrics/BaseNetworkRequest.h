//
//  BaseNetworkRequest.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/3/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkAvailabilityUtils.h"

@protocol BaseNetworkDelefate <NSObject>

@required
-(void) sucessOnRequest:(NSDictionary*) jsonArray AndIdentifier:(NSString*) identifier;
-(void) errorOnRequest:(NSString*) identifier;
-(void) errorOnRequest:(NSString*) identifier AndResponseCode:(int) code;
-(void) noConnectivity;

@end

@interface BaseNetworkRequest : NSObject

#pragma Properties

@property (nonatomic, strong) NSURL *url;
@property (nonatomic,strong) id <BaseNetworkDelefate> delegate;
@property (nonatomic,strong) NSString* identifier;

#pragma Methods

-(void) startGetRequest;
-(void) startPostRequest:(NSData*)postBody;
-(void) startPostMultipartDataRequest:(NSDictionary *)postParameters;
@end