//
//  EWLPlayerViewController.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 3/28/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <UIKit/UIKit.h>

//Libraries
#import <MediaPlayer/MediaPlayer.h>
#import <MBProgressHUD/MBProgressHUD.h>

//Categories
#import "UILabel+UtilityAttributes.h"
#import "UIImage+ImageEffects.h"

//Models
#import "EWLBaseLyricFindResponse.h"
#import "EWLSearchArtistSongLyricWithoutLyricsResponse.h"
#import "EWLSearchArtistSongLyricWithLyricsResponse.h"
#import "EWLSearchArtistSongLyricWithLyricsItem.h"
#import "EWLGracenoteIdentifySongResponse.h"

//ViewControllers
#import "EWLLanguagePickerViewController.h"

//Others
#import "EWLStringUtils.h"
#import "EWLSearchSongByArtistJSONParser.h"

@interface EWLPlayerViewController : EWLBaseViewController<EWLLanguagePickerViewControllerDelegate,BaseNetworkDelefate>

@property(strong,nonatomic) EWLBaseLyricFindResponse* baseResponse;
@property (strong,nonatomic) MPMediaItemCollection* mediaItemCollection;
@property (strong,nonatomic) EWLGracenoteIdentifySongResponse* identifySongResponse;
@property (strong,nonatomic) UIImage* itunesAlbumArtworkImage;

@end
