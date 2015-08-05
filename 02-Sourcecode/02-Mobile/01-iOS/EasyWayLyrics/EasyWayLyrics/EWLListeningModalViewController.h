//
//  EWLListeningModalViewController.h
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 4/17/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLBaseViewController.h"

//Libraries
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <SDWebImage/SDWebImageManager.h>

//Echonest Codegen
#import "MicrophoneInput.h"

//GracenoteMusic
#import <GracenoteMusicID/GNRecognizeStream.h>
#import <GracenoteMusicID/GNAudioSourceMic.h>
#import <GracenoteMusicID/GNAudioConfig.h>
#import <GracenoteMusicID/GNCacheStatus.h>
#import <GracenoteMusicID/GNConfig.h>
#import <GracenoteMusicID/GNSampleBuffer.h>
#import <GracenoteMusicID/GNOperations.h>
#import <GracenoteMusicID/GNSearchResponse.h>
#import <GracenoteMusicID/GNSearchResult.h>

//Models
#import "EWLBaseLyricFindResponse.h"
#import "EWLGracenoteIdentifySongResponse.h"

//UI
#import "EWLUILabelBase.h"
#import "LoadingAnimationDrawing.h"

//Protocols
#import "EWLListeningModalViewControllerDelegate.h"

//Others
#import "EWLItunesArtworkRequest.h"
#import "EWLSearchSongByArtistJSONParser.h"
#import "EWLGracenoteIdentifySongJSONParser.h"

@interface EWLListeningModalViewController : EWLBaseViewController<BaseNetworkDelefate,UIAlertViewDelegate,GNSearchResultReady,GNAudioSourceDelegate>

@property (nonatomic,strong) id<EWLListeningModalViewControllerDelegate> delegate;

@end
