//
//  EWLViewController.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 3/24/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLHomeViewController.h"

@interface EWLHomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIButton *chooseSongButton;
@property (weak, nonatomic) IBOutlet UIButton *syncWithRadioTVButton;
@property (weak, nonatomic) IBOutlet UIButton *bookPrivateEnglishLessonButton;
@property (weak, nonatomic) IBOutlet UIButton *shareThisAppButton;

//Sync
@property (strong,nonatomic) EWLGracenoteIdentifySongResponse* identifySongResponse;
@property (strong,nonatomic) NSDate* dateStartedSync;
//[Sync/Library]
@property (strong,nonatomic) EWLBaseLyricFindResponse* baseResponse;
@property (strong,nonatomic) UIImage* itunesAlbumArtworkImage;
//Library
@property (strong,nonatomic) MPMediaItemCollection* mediaItemCollection;
//Gracenote
@property (strong,nonatomic) GNConfig *config;

@end

@implementation EWLHomeViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @try {
		self.config = [GNConfig init:GRACENOTE_CLIENTID];
	}
	@catch (NSException * e) {
		NSLog(@"%s clientId can't be nil or the empty string",__PRETTY_FUNCTION__);
		return;
	}
	
	// Debug is disabled in the GUI by default
#ifdef DEBUG
	[self.config setProperty:@"debugEnabled" value:@"1"];
#else
    [self.config setProperty:@"debugEnabled" value:@"0"];
#endif
    [self.config setProperty:@"lookupmodelocalonly" value:@"0"];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self switchNavigationBarVisibility:NO];

    EWLBackgroundBlurImage *backgroundBlueImageSingleton = [EWLBackgroundBlurImage sharedInstance];
    
    if(backgroundBlueImageSingleton.albumBlurBackground){
        self.backgroundImageView.image = backgroundBlueImageSingleton.albumBlurBackground;
    }else{
        self.backgroundImageView.image = [UIImage imageNamed:@"common_background"];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"HomeToPlayerSegue"])
    {
        EWLPlayerViewController* vc = segue.destinationViewController;
        vc.baseResponse = self.baseResponse;
        vc.mediaItemCollection = self.mediaItemCollection;
        vc.itunesAlbumArtworkImage  = self.itunesAlbumArtworkImage;
        vc.identifySongResponse = self.identifySongResponse;
    }else if([segue.identifier isEqualToString:@"HomeToSyncPlayerSegue"])
    {
        EWLSyncPlayerViewController* vc = segue.destinationViewController;
        vc.baseResponse = self.baseResponse;
        vc.itunesAlbumArtworkImage  = self.itunesAlbumArtworkImage;
        vc.identifySongResponse = self.identifySongResponse;
        vc.dateStartedSync = self.dateStartedSync;
        vc.delegate = self;
    }
}

#pragma mark - Actions

- (IBAction)touchUpChooseSongButton:(id)sender
{
    MPMediaPickerController *mediaPickerVC = [[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeMusic];
    mediaPickerVC.allowsPickingMultipleItems   = NO;
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated: YES];
    mediaPickerVC.delegate = self;
    [self presentViewController:mediaPickerVC animated:YES completion:nil];
    
}
- (IBAction)touchUpSyncSongButton:(id)sender {
    EWLListeningModalViewController* vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EWLListeningModalViewController"];
    vc.delegate = self;
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)touchUpBookPrivateEnglishLessonsButton:(id)sender {
    [self switchNavigationBarVisibility:YES];
    [self performSegueWithIdentifier:@"HomeToBookSegue" sender:sender];
}
- (IBAction)touchUpShareThisAppButton:(id)sender {
    [self openShareSheet:[EWLConstants TEXT_SHARE]];
}

#pragma mark - MPMediaPickerControllerDelegate methods

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
    [mediaPicker dismissViewControllerAnimated:YES completion:^{
        //TODO: This is intented to handle only one music at time
        NSString *artist = @"";
        NSString *songTitle = @"";
        for (int i=0; i < mediaItemCollection.count; i++) {
            MPMediaItem *mpItem = [mediaItemCollection.items objectAtIndex:i];
            artist = [mpItem valueForProperty:MPMediaItemPropertyArtist];
            songTitle = [mpItem valueForProperty:MPMediaItemPropertyTitle];
            
            break;
        }
        self.mediaItemCollection = mediaItemCollection;
        if (artist && songTitle)
        {
            [self searchLyrics:artist AndSong:songTitle];
        }else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"Identifying Song ....";
            
            [GNOperations albumIdFromMPMediaItemCollection:self config:self.config collection:mediaItemCollection];
        }
        
    }];
    
}

-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - BaseNetworkDelegate methods

-(void) searchLyrics:(NSString*) artist AndSong:(NSString*) song{
#ifdef DEBUG
    NSLog(@"%s Artist: %@ Song: %@",__PRETTY_FUNCTION__, artist, song);
#endif
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Getting Lyrics ....";
    
    BaseNetworkRequest *searchArtistSongRequest = [[BaseNetworkRequest alloc] init];
    [searchArtistSongRequest setDelegate:self];
    [searchArtistSongRequest setUrl:[NSURL URLWithString:[EWLConstants SEARCH_LYRICS_SERVICE:artist AndSong:song AndToLang:@"default"]]];
    [searchArtistSongRequest setIdentifier:@"searchArtistSongRequest"];
    [searchArtistSongRequest startGetRequest];
}

-(void) searchAlbumArtwork:(NSString*) artist AndSong:(NSString*) song{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Getting Album Artwork ....";
    
    EWLItunesArtworkRequest *searchAlbumArtworkRequest = [[EWLItunesArtworkRequest alloc] init];
    [searchAlbumArtworkRequest setDelegate:self];
    [searchAlbumArtworkRequest setUrl:[NSURL URLWithString:[[NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@ %@",artist,song] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [searchAlbumArtworkRequest setIdentifier:@"searchAlbumArtworkRequest"];
    [searchAlbumArtworkRequest startGetRequest];
}

- (void)goToPlayerController {
    [self switchNavigationBarVisibility:YES];
    [self performSegueWithIdentifier:@"HomeToPlayerSegue" sender:self];
}

-(void)sucessOnRequest:(NSDictionary *)jsonArray AndIdentifier:(NSString *)identifier{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if([identifier isEqualToString:@"searchArtistSongRequest"])
    {
        self.baseResponse = [[[EWLSearchSongByArtistJSONParser alloc]init] parseSuccessfulResponse:jsonArray];
        
        //TODO: This is intented to handle only one music at time
        NSString *artist = @"";
        NSString *songTitle = @"";
        UIImage *imageArtWork = nil;
        for (int i=0; i < self.mediaItemCollection.count; i++) {
            MPMediaItem *mpItem = [self.mediaItemCollection.items objectAtIndex:i];
            artist = [mpItem valueForProperty:MPMediaItemPropertyArtist];
            songTitle = [mpItem valueForProperty:MPMediaItemPropertyTitle];
            if ([mpItem valueForProperty:MPMediaItemPropertyArtwork]){
                imageArtWork = [((MPMediaItemArtwork*)[mpItem valueForProperty:MPMediaItemPropertyArtwork]) imageWithSize:CGSizeMake(319, 292)];
            }
            break;
        }
        
        if(imageArtWork)
        {
            [self goToPlayerController];
        }
        else
        {
            if (artist && songTitle){
                [self searchAlbumArtwork:artist AndSong:songTitle];
            }else{
                [self searchAlbumArtwork:self.identifySongResponse.artist AndSong:self.identifySongResponse.song];
            }
            
        }
    }else if([identifier isEqualToString:@"searchAlbumArtworkRequest"])
    {
        NSNumber *resultCount = [jsonArray objectForKey:@"resultCount"];
        if([resultCount intValue] > 0){
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"Downloading Album Artwork ....";
            
            NSDictionary* jsonResultObj = [[jsonArray objectForKey:@"results"] objectAtIndex:0];
            NSString* urlAlbumArtwork = [[jsonResultObj objectForKey:@"artworkUrl100"] stringByReplacingOccurrencesOfString:@"100x100" withString:@"400x400"];
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadWithURL:[NSURL URLWithString:urlAlbumArtwork]
                             options:0
                            progress:nil
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
             {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];

                 if (image)
                 {
                     self.itunesAlbumArtworkImage = image;
                 }
                 [self goToPlayerController];
             }];
        }else{
            [self goToPlayerController];
        }
    }
}

-(void) errorOnRequest:(NSString *)identifier
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [EWLAlertViewUtils buildAlertForErrorRequest];
    [alert show];
    
}

-(void) noConnectivity
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [EWLAlertViewUtils buildAlertForNoConnectivity];
    [alert show];
}

-(void)errorOnRequest:(NSString *)identifier AndResponseCode:(int)code
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if([identifier isEqualToString:@"searchArtistSongRequest"] && code == -2)
    {
        UIAlertView *alert = [EWLAlertViewUtils buildAlertForSongNotFoundRequest];
        [alert show];
    }
}

#pragma mark - EWLListeningModalViewControllerDelegate methods

-(void)successfulOnListeningDataRetrieval:(EWLGracenoteIdentifySongResponse *)identifySongResponse AndBaseLyricFindResponse:(EWLBaseLyricFindResponse *)baseResponse AndAlbumArtworkImage:(UIImage *)itunesAlbumArtworkImage AndDateStartedSync:(NSDate *)dateStartedSync{
    
    self.identifySongResponse = identifySongResponse;
    self.baseResponse = baseResponse;
    self.itunesAlbumArtworkImage = itunesAlbumArtworkImage;
    self.dateStartedSync = dateStartedSync;
    
    [self switchNavigationBarVisibility:YES];
    [self performSegueWithIdentifier:@"HomeToSyncPlayerSegue" sender:self];
}
-(void)errorOnListeningDataRetrieval{
    self.identifySongResponse = nil;
    self.baseResponse = nil;
    self.itunesAlbumArtworkImage = nil;
}

-(void)cancelOnListening{
    self.identifySongResponse = nil;
    self.baseResponse = nil;
    self.itunesAlbumArtworkImage = nil;
}

#pragma mark - EWLSyncPlayerViewControllerDelegate methods

-(void)reSyncMusic{
    [self touchUpSyncSongButton:nil];
}

#pragma mark - GNSearchResultReady methods
- (void) GNResultReady:(GNSearchResult*)result{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
#ifdef DEBUG
    NSLog(@"%s",__PRETTY_FUNCTION__);
#endif
	GNSearchResponse *response = nil;
    
	if ([result isFailure]) {
		UIAlertView *alert = [EWLAlertViewUtils buildAlertForNotIdentifiedSongLibrary];
        alert.delegate = self;
        [alert show];
	} else {
		if ([result isAnySearchNoMatchStatus]) {
            UIAlertView *alert = [EWLAlertViewUtils buildAlertForNotIdentifiedSongLibrary];
            alert.delegate = self;
            [alert show];
		} else {
			response = [[result responses] firstObject];
#ifdef DEBUG
            NSString *statusString = [NSString stringWithFormat:@"Found %lu", (unsigned long)[result responses].count];
            NSLog(@"%s %@",__PRETTY_FUNCTION__,statusString);
#endif
            self.identifySongResponse = [[[EWLGracenoteIdentifySongJSONParser alloc] init] parseSuccessfulResponse:response];
            
            [self searchLyrics:self.identifySongResponse.artist AndSong:self.identifySongResponse.song];
		}
	}
    
}

@end
