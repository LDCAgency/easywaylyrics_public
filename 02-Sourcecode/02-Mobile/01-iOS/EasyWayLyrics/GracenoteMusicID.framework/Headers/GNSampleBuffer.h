//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

extern float GNSampleBufferMIDStreamMinSampleSeconds;
extern float GNSampleBufferMIDStreamMaxSampleSeconds;

/** 
 * Base class for a PCM-encoded audio sample.
 */
@interface GNSampleBuffer : NSObject {
	
@protected
	NSData* m_samples;
	int m_bytesPerSample;
	int m_numChannels;
	int m_sampleRate;
}

@property (nonatomic, copy) NSData *samples;


// Create a buffer of PCM data that will be passed into the fingerprinter.
//
// inSamples a buffer of PCM samples
// inBytesPerSample the number of bytes in a sample, 1 for 8bit mono, 2 for 16bit mono, 4 for 16bit stereo
// inNumChannels the number of channels, 1 for mono, 2 for stereo
// inSampleRate on of 8000, 11025, 16000, 22050, 24000, 32000, 44100, 48000

/**
 * Creates a buffer for a PCM-encoded audio sample that can be provided to fingerprint
 * generation or recognition operations.
 * @param inSamples Buffer containing the PCM audio samples.
 * @param inBytesPerSample The number of bytes allocated for each sample in the inSamples buffer.
 * For example, 1 for 8-bit mono, 2 for 16-bit mono, and 4 for 16-bit stereo.
 * @param inNumChannels The number of channels encoded in the audio in the inSamples buffer.
 * For example, 1 for mono and 2 for stereo.
 * @param inSampleRate The sample rate of the audio in the inSamples buffer.
 * Mobile Client supports the following sampling rates: 8000, 11025, 16000, 22050, 24000, 32000, 44100, and 48000.
 */

+ (GNSampleBuffer*) gNSampleBuffer:(NSData*)inSamples
                    bytesPerSample:(int)inBytesPerSample
                       numChannels:(int)inNumChannels
                        sampleRate:(int)inSampleRate;  

// Create a buffer of PCM data for the most common case of 16bit samples.

/**
 * Creates a buffer for a 16-bit PCM-encoded audio sample that can be provided to fingerprint
 * generation or recognition operations.
 * @param inSamples Buffer containing the PCM audio samples.
 * @param inNumChannels The number of channels encoded in the audio in the inSamples buffer.
 * For example, 1 for mono and 2 for stereo.
 * @param inSampleRate The sampling rate of the audio in the inSamples buffer.
 * Mobile Client supports the following sampling rates: 8000, 11025, 16000, 22050, 24000, 32000, 44100, and 48000.
 */

+ (GNSampleBuffer*) gNSampleBuffer:(NSData*)inSamples
                       numChannels:(int)inNumChannels
                        sampleRate:(int)inSampleRate;

/**
 * Creates a buffer for a 16-bit PCM-encoded audio sample that can be provided to fingerprint
 * generation or recognition operations.
 * @param inSamples Buffer containing the PCM audio samples.
 * @param inNumChannels The number of channels encoded in the audio in the inSamples buffer.
 * For example, 1 for mono and 2 for stereo.
 * @param inSampleRate The sampling rate of the audio in the inSamples buffer.
 * Mobile Client supports the following sampling rates: 8000, 11025, 16000, 22050, 24000, 32000, 44100, and 48000.
 * @param fpblockLength Length of respective Fingerprint Block.
 */

+ (GNSampleBuffer*) gNSampleBuffer:(NSData*)inSamples
                       numChannels:(int)inNumChannels
                        sampleRate:(int)inSampleRate
                     bufferStartTimeInterval:(NSTimeInterval) inBufferStartTimeInterval;


@end
