//
//  NetworkAvailabilityUtils.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/3/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetworkAvailabilityUtils : NSObject
@property (nonatomic,strong) Reachability *reachability ;

+(NetworkAvailabilityUtils*) instance;
+(BOOL) isConnected;
@end