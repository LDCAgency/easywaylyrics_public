//
//  GNAudioConfig.h
//  iOSMobileSDK
//
//  Copyright Gracenote Inc. 2013. All rights reserved.
//
//
//

#import <Foundation/Foundation.h>

@class GNAudioConfig;
@interface GNAudioConfig : NSObject{
    
}

/**
 *  Initializes and returns a new GNAudioConfig with the specified parameters.
 *  sampleRate should be 8000, 44100, 48000
 *  bytesPerSample should be either 1 (PCM8) or 2 (PCM16)
 *  numChannels should be either 1 (mono) or 2 (stereo)
 */

+ (GNAudioConfig*) gNAudioConfigWithSampleRate:(int)inSampleRate
                    bytesPerSample:(int)inBytesPerSample
                       numChannels:(int)inNumChannels;

/**
 *  A property to access the sample format of the GnAudioConfig object.
 */
@property (nonatomic, readonly) int bytesPerSample;

/**
 *  A property to access the number of channels of the GnAudioConfig object.
 */
@property (nonatomic, readonly) int numChannels;

/**
 *  A property to access the AudioSampleRate of the GnAudioConfig object.
 */
@property (nonatomic, readonly) int sampleRate;


@end
