//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

#import "GNAudioSourceDelegate.h" // for GNAudioSourceDelegate protocol

@class GNFingerprinter;

@interface GNAudioSource : NSObject {
	short	m_channels;
	int32_t	m_sampleRate;
	short	m_bitsPerChannel;
	id<GNAudioSourceDelegate> _delegate;
}

@property (nonatomic, assign) short channels;
@property (nonatomic, assign) int32_t sampleRate;
@property (nonatomic, assign) short bitsPerChannel;
@property (nonatomic, assign) id<GNAudioSourceDelegate> delegate;

// public interface 
// callbacks that need to be implemented by all GNAudioSources

- (OSStatus)startRecording;
- (OSErr)stopRecording;
- (NSError*)startConveting;

// util method to invoke delegate callback

- (void) notifyDelegate:(NSData*)samples;

@end
