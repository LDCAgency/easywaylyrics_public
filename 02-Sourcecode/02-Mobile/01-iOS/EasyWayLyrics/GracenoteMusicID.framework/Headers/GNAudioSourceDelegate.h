//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//
// This delegate interface should be implemented by a class that
// processed audio bytes. A delegate is needed so that the
// class that a ref to the containing class is not held by the
// GNAudioSource object.

/*
 *  This delegate interface should be implemented by a class that processes audio bytes. A delegate will be called by GNAudioSource object when bytes are available.
 */
#import <Foundation/Foundation.h>

@class GNAudioSource;

// Delegate interface

@protocol GNAudioSourceDelegate

/*
 * Delegate method. This method should be implemented to process the audio buffer received from GNAudioSourceMic. SDK will callback once audio bytes are available.
 *  Example:
 * - (void) audioBufferDidBecomeReady:(GNAudioSource*)audioSource samples:(NSData*)samples {
 *  NSError * err = nil;
 *  err = [self.recognizeFromPCM writeBytes:samples];
 *  if (err) {
 *      NSLog(@"ERROR: %@",[err localizedDescription]);
 *  }
 * }
 */
- (void) audioBufferDidBecomeReady:(GNAudioSource*)audioSource samples:(NSData*)samples;

@end

