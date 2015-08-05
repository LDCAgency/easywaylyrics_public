//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GNConfig.h"
#import "GNSearchResultReady.h"
#import "GNOperationStatusChanged.h"

@class GNAudioConfig;

@interface GNRecognizeStream : NSObject{
    
}

/**
 * Initializes a new GNRecognizeStream object with the Application's GNConfig object and GNSearchResultReady.
 */

+(GNRecognizeStream*) gNRecognizeStream:(GNConfig*)inConfig;

/**
 * Starts the stream processing session by initializing objects needed to allow writeBytes to continuously feed audio samples to a buffer.
 */

-(NSError*)startRecognizeSession:(id<GNSearchResultReady>)resultReady audioConfig:(GNAudioConfig *)inAudioConfig;

/**
 * Stops the stream processing session, releasing all resources allocated by startSession()
 */

-(NSError*)stopRecognizeSession;

/**
 * Writes PCM audio data to the GNRecognizeStream object.
 */


-(NSError*)writeBytes:(NSData *)samples;

/**
 * Performs  audio stream recognition and stores results in the Result Ready object passed to the startSession call.
 */

-(NSError*)idNow;

/**
 * Cancels idNow request.
 */

-(void)cancelIdNow;

@end
