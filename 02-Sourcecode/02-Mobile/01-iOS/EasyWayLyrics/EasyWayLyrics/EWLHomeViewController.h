//
//  EWLViewController.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 3/24/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <UIKit/UIKit.h>

//Libraries
#import <MediaPlayer/MediaPlayer.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/SDWebImageManager.h>
#import <GracenoteMusicID/GNConfig.h>
#import <GracenoteMusicID/GNOperations.h>
#import <GracenoteMusicID/GNResult.h>

//ViewControllers
#import "EWLPlayerViewController.h"
#import "EWLSyncPlayerViewController.h"
#import "EWLListeningModalViewController.h"

//Models
#import "EWLBaseLyricFindResponse.h"
#import "EWLGracenoteIdentifySongResponse.h"

//Protocols
#import "EWLListeningModalViewControllerDelegate.h"
#import "EWLSyncPlayerViewControllerDelegate.h"

//Others
#import "EWLItunesArtworkRequest.h"
#import "EWLSearchSongByArtistJSONParser.h"

@interface EWLHomeViewController : EWLBaseViewController<MPMediaPickerControllerDelegate,BaseNetworkDelefate,EWLListeningModalViewControllerDelegate,EWLSyncPlayerViewControllerDelegate,GNSearchResultReady>

@end
