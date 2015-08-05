//
//  MicrophoneInput.m
//  Echoprint
//
//  Created by Brian Whitman on 1/23/11.
//  Copyright 2011 The Echo Nest. All rights reserved.
//

#import "MicrophoneInput.h"


@implementation MicrophoneInput

- (void)viewDidLoad
{
    [super viewDidLoad];
    recordEncoding = ENC_PCM;
}

-(IBAction) startRecording
{
	NSLog(@"startRecording");
	[audioRecorder release];
	audioRecorder = nil;
	
	// Init audio with record capability
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	[audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
	
	NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
	recordSettings[AVFormatIDKey] = @(kAudioFormatLinearPCM);
	recordSettings[AVSampleRateKey] = @8000.0f;
	recordSettings[AVNumberOfChannelsKey] = @1;
	recordSettings[AVLinearPCMBitDepthKey] = @16;
	recordSettings[AVLinearPCMIsBigEndianKey] = @NO;
	recordSettings[AVLinearPCMIsFloatKey] = @NO;   
	
	//set the export session's outputURL to <Documents>/output.caf
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = paths[0];
	NSURL* outURL = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:@"output.caf"]];
	[[NSFileManager defaultManager] removeItemAtURL:outURL error:nil];
#ifdef DEBUG
	NSLog(@"url loc is %@", outURL);
#endif
	
	NSError *error = nil;
	audioRecorder = [[ AVAudioRecorder alloc] initWithURL:outURL settings:recordSettings error:&error];
	
	if ([audioRecorder prepareToRecord] == YES){
		[audioRecorder record];
	}else {
		int errorCode = CFSwapInt32HostToBig ((uint32_t)[error code]);
		NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode); 
		
	}
#ifdef DEBUG
	NSLog(@"recording");
#endif
}

-(IBAction) stopRecording
{
#ifdef DEBUG
	NSLog(@"stopRecording");
#endif
	[audioRecorder stop];
#ifdef DEBUG
	NSLog(@"stopped");
#endif
}


- (void)dealloc
{
	[audioPlayer release];
	[audioRecorder release];
	[super dealloc];
}


@end
