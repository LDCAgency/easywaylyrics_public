//
//  GnAudioSourceMic.h
//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2013. All rights reserved.
//
//
//

/*
 *  Gracenote recording wrapper class, provides audio recording capability in your application.
 *  Using a GNAudioSourceMic you can
 *    - Record until user stops the recording.
 *    - Pause and resume a recording.
 */

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "GNAudioSource.h"

@class GNAudioSourceMic;

@interface GNAudioSourceMic : GNAudioSource{

}

/*
 *  Acquires audio input hardware resource and initializes it as specified by audioConfig.
 */

+ (GNAudioSourceMic*) gNAudioSourceMic:(GNAudioConfig*)audioConfig;
/*
 *  Starts or resumes recording.
 */

- (OSStatus)startRecording;

/*
 *  Stops recording, and releases the audio input hardware resource.
 */

- (OSStatus)stopRecording;
/*
 *  Pauses a recording. Call startRecording to resume.
 */

- (OSStatus) pauseRecording;

@end
