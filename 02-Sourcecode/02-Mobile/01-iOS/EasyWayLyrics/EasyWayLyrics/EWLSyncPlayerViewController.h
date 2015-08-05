//
//  EWLSyncPlayerViewController.h
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 5/1/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLBaseViewController.h"

//Libraries
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

//Protocols
#import "EWLSyncPlayerViewControllerDelegate.h"

//Others
#import "EWLStringUtils.h"
#import "EWLSearchSongByArtistJSONParser.h"

@interface EWLSyncPlayerViewController : EWLBaseViewController<EWLLanguagePickerViewControllerDelegate,BaseNetworkDelefate>
@property (strong,nonatomic) EWLGracenoteIdentifySongResponse* identifySongResponse;
@property(strong,nonatomic) EWLBaseLyricFindResponse* baseResponse;
@property (strong,nonatomic) UIImage* itunesAlbumArtworkImage;
@property (strong,nonatomic) NSDate* dateStartedSync;

@property (nonatomic,strong) id<EWLSyncPlayerViewControllerDelegate> delegate;
@end
