//
//  NetworkAvailabilityUtils.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/3/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "NetworkAvailabilityUtils.h"


@implementation NetworkAvailabilityUtils

static NetworkAvailabilityUtils *instance;

static bool isConnected;

+(NetworkAvailabilityUtils*) instance
{
    if(instance == NULL)
    {
        instance = [[self alloc]init];
    }
    return instance;
}

+(BOOL) isConnected
{
    return isConnected;
}

- (id)init {
    if ( (self = [super init]) ) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kReachabilityChangedNotification object:nil];
        
        _reachability = [Reachability reachabilityForInternetConnection];
        [_reachability startNotifier];
        
        //Perform a first check in order to get the actual scenario
        [self networkChanged:nil];
    }
    return self;
}


- (void)networkChanged:(NSNotification *)notification
{
    
    NetworkStatus remoteHostStatus = [_reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
    {
        NSLog(@"not reachable");
        isConnected = NO;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        NSLog(@"wifi");
        isConnected = YES;
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        NSLog(@"carrier");
        isConnected = YES;
    }
}

@end