//
//  EWLListeningModalViewController.m
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 4/17/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLListeningModalViewController.h"

@interface EWLListeningModalViewController ()
//Ui
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet EWLUILabelBase *listeningLabel;
@property (weak, nonatomic) IBOutlet LoadingAnimationDrawing *loadingAnimationView;
;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *timerLoadingAnimating;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
//identifySongRequest
@property (strong,nonatomic) EWLGracenoteIdentifySongResponse* identifySongResponse;
@property (strong,nonatomic) NSDate* dateStartedSync;
//SearchArtistSongRequest
@property (strong,nonatomic) EWLBaseLyricFindResponse* baseResponse;
@property (strong,nonatomic) UIImage* itunesAlbumArtworkImage;
//Record
@property (strong,nonatomic) GNConfig *config;
@property (nonatomic, retain) GNAudioConfig *audioConfig;
@property (nonatomic, retain) GNAudioSourceMic *objAudioSource;
@property (nonatomic, retain) GNRecognizeStream *recognizeFromPCM;

//Cancel handling
@property(nonatomic) BOOL cancelled;
@end

@implementation EWLListeningModalViewController

int amountOfDots;

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [self setupUI];
    
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
    
    self.recognizeFromPCM = [GNRecognizeStream gNRecognizeStream:self.config];
    
    self.audioConfig = [GNAudioConfig gNAudioConfigWithSampleRate:44100 bytesPerSample:2 numChannels:1];

    self.objAudioSource = [GNAudioSourceMic gNAudioSourceMic:self.audioConfig];
    self.objAudioSource.delegate=self;
    
    NSError *err;
    
    err = [self.recognizeFromPCM startRecognizeSession:self audioConfig:self.audioConfig];
    
    if (err) {
        NSLog(@"ERROR: %@",[err localizedDescription]);
    }
    
    [self.objAudioSource startRecording];
    
    [self performSelectorInBackground:@selector(setUpRecognizePCMSession) withObject:nil];

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void) setupUI{
    self.listeningLabel.text = @"Listening ";
    self.timerLoadingAnimating.hidden = YES;
    self.cancelled = NO;

    //Adding Notifications for when use suddently puts it on background for some reason
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationResignedActive:) name:UIApplicationWillResignActiveNotification object:nil];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    EWLBackgroundBlurImage *backgroundBlueImageSingleton = [EWLBackgroundBlurImage sharedInstance];
    
    if(backgroundBlueImageSingleton.albumBlurBackground){
        self.backgroundImageView.image = backgroundBlueImageSingleton.albumBlurBackground;
    }else{
        self.backgroundImageView.image = [UIImage imageNamed:@"common_background"];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.timerLoadingAnimating stopAnimating];
}

-(void)viewDidAppear:(BOOL)animated{
    [self performSelectorInBackground:@selector(startRecordMicrophone) withObject:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)setUpRecognizePCMSession{
    
    NSString *bundleFileName = @"161.b";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:bundleFileName ofType:nil];
    
    if (filePath !=nil && filePath.length != 0) {
        GNCacheStatus *status = [self.config loadCache:filePath];
        NSLog(@"Load Cache Status : %@",[status statusString]);
    }
    
    NSString *sdkVersion = [self.config getProperty:@"version"];
	NSString *version = [NSString stringWithFormat:@"GNSDK %@", sdkVersion];
    
#if __LP64__
    version = [version stringByAppendingString:@"   64 bit"];
#else
    version = [version stringByAppendingString:@"   32 bit"];
#endif
    
}

-(void) startRecordMicrophone{
    #ifdef DEBUG
        NSLog(@"%s startRecording",__PRETTY_FUNCTION__);
    #endif
    self.dateStartedSync = [NSDate date];

    NSError *error;
    error = [self.recognizeFromPCM idNow];
    
    
    if (error) {
        NSLog(@"ERROR: %@",[error localizedDescription]);
    }

    [self performSelectorOnMainThread:@selector(makeMyProgressBarMoving) withObject:nil waitUntilDone:NO];
}

#pragma mark - Recording interrurpt handler

- (void) applicationResignedActive:(NSNotification *)notification {
#ifdef DEBUG
    NSLog(@"%s",__PRETTY_FUNCTION__);
#endif
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    [self.objAudioSource stopRecording];
    self.cancelled = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UI methods

-(void)makeMyProgressBarMoving {
    if(!self.cancelled){
        float actual = [self.progressBar progress];
        if (actual < 1) {
            [self.loadingAnimationView showNextLevel];
            self.progressBar.progress = actual + 0.0125;
#ifdef DEBUG
            NSLog(@"%s self.progressBar.progress: %f",__PRETTY_FUNCTION__,self.progressBar.progress);
#endif
            [NSTimer scheduledTimerWithTimeInterval:0.25f target:self selector:@selector(makeMyProgressBarMoving) userInfo:nil repeats:NO];
        }
        else{
            [self.loadingAnimationView clearLevel];
            self.progressBar.hidden = YES;
            self.timerLoadingAnimating.hidden = NO;
            [self.timerLoadingAnimating startAnimating];
        }
   
    }
}

-(void) goToSyncPlayer{
    if(!self.cancelled){
        [self dismissViewControllerAnimated:YES completion:^{
            if(self.delegate){
                [self.delegate successfulOnListeningDataRetrieval:self.identifySongResponse AndBaseLyricFindResponse:self.baseResponse AndAlbumArtworkImage:self.itunesAlbumArtworkImage AndDateStartedSync:self.dateStartedSync];
            }
        }];
    }
}

#pragma mark - Actions methods

- (IBAction)touchUpTransparentView:(id)sender {
    self.cancelled = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - BaseNetworkDelegate methods


-(void) searchArtistSongRequest:(NSString*) artist AndSong:(NSString*) song{
    self.listeningLabel.text = @"Getting lyrics ";
    
    BaseNetworkRequest *searchArtistSongRequest = [[BaseNetworkRequest alloc] init];
    [searchArtistSongRequest setDelegate:self];
    [searchArtistSongRequest setUrl:[NSURL URLWithString:[EWLConstants SEARCH_LYRICS_SERVICE:artist AndSong:song AndToLang:@"default"]]];
    [searchArtistSongRequest setIdentifier:@"searchArtistSongRequest"];
    [searchArtistSongRequest startGetRequest];
}

-(void) searchAlbumArtwork:(NSString*) artist AndSong:(NSString*) song{
    self.listeningLabel.text = @"Getting Album Artwork ";
    
    EWLItunesArtworkRequest *searchAlbumArtworkRequest = [[EWLItunesArtworkRequest alloc] init];
    [searchAlbumArtworkRequest setDelegate:self];
    [searchAlbumArtworkRequest setUrl:[NSURL URLWithString:[[NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@ %@",artist,song] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [searchAlbumArtworkRequest setIdentifier:@"searchAlbumArtworkRequest"];
    [searchAlbumArtworkRequest startGetRequest];
}

-(void)sucessOnRequest:(NSDictionary *)jsonArray AndIdentifier:(NSString *)identifier{

    if(!self.cancelled){
        if([identifier isEqualToString:@"searchArtistSongRequest"])
        {
            self.baseResponse = [[[EWLSearchSongByArtistJSONParser alloc]init] parseSuccessfulResponse:jsonArray];
            [self searchAlbumArtwork:self.identifySongResponse.artist AndSong:self.identifySongResponse.song];
        }else if([identifier isEqualToString:@"searchAlbumArtworkRequest"])
        {
            NSNumber *resultCount = [jsonArray objectForKey:@"resultCount"];
            if([resultCount intValue] > 0){
                
                NSDictionary* jsonResultObj = [[jsonArray objectForKey:@"results"] objectAtIndex:0];
                NSString* urlAlbumArtwork = [[jsonResultObj objectForKey:@"artworkUrl100"] stringByReplacingOccurrencesOfString:@"100x100" withString:@"400x400"];
                
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                [manager downloadWithURL:[NSURL URLWithString:urlAlbumArtwork]
                                 options:0
                                progress:nil
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
                 {
                     
                     if (image)
                     {
                         self.itunesAlbumArtworkImage = image;
                     }
                     [self goToSyncPlayer];
                 }];
                
                
            }else{
                [self goToSyncPlayer];
            }
        }else if([identifier isEqualToString:@"syncingSongRequest"])
        {
            [self goToSyncPlayer];

        }
    }
}

-(void) errorOnRequest:(NSString *)identifier
{
    if([identifier isEqualToString:@"identifySongRequest"])
    {
        UIAlertView *alert = [EWLAlertViewUtils buildAlertForNotIdentifiedSong];
        alert.delegate = self;
        [alert show];
    }
    else if([identifier isEqualToString:@"searchAlbumArtworkRequest"])
    {
        if(!self.cancelled){
            [self goToSyncPlayer];
        }
    }
    else
    {
        UIAlertView *alert = [EWLAlertViewUtils buildAlertForErrorRequest];
        alert.delegate=self;
        [alert show];
    }
}

-(void)errorOnRequest:(NSString *)identifier AndResponseCode:(int)code
{
    if([identifier isEqualToString:@"searchArtistSongRequest"] && code == -2)
    {
        UIAlertView *alert = [EWLAlertViewUtils buildAlertForSongNotFoundRequest];
        alert.delegate=self;
        [alert show];
    }
}

-(void) noConnectivity
{
    UIAlertView *alert = [EWLAlertViewUtils buildAlertForNoConnectivity];
    alert.delegate=self;
    [alert show];
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - GNAudioSourceDelegate methods
- (void) audioBufferDidBecomeReady:(GNAudioSource*)audioSource samples:(NSData*)samples {
    NSError *err;
    err = [self.recognizeFromPCM writeBytes:samples];
    
    if (err) {
        NSLog(@"ERROR: %@",[err localizedDescription]);
    }
}

#pragma mark - GNSearchResultReady methods
- (void) GNResultReady:(GNSearchResult*)result{
    self.progressBar.progress = 1;
#ifdef DEBUG
    NSLog(@"%s",__PRETTY_FUNCTION__);
#endif
	GNSearchResponse *response = nil;
    
	if ([result isFailure]) {
		UIAlertView *alert = [EWLAlertViewUtils buildAlertForNotIdentifiedSong];
        alert.delegate = self;
        [alert show];
	} else {
		if ([result isAnySearchNoMatchStatus]) {
            UIAlertView *alert = [EWLAlertViewUtils buildAlertForNotIdentifiedSong];
            alert.delegate = self;
            [alert show];
		} else {
			response = [[result responses] firstObject];
#ifdef DEBUG
            NSString *statusString = [NSString stringWithFormat:@"Found %lu", (unsigned long)[result responses].count];
            NSLog(@"%s %@",__PRETTY_FUNCTION__,statusString);
#endif
            self.identifySongResponse = [[[EWLGracenoteIdentifySongJSONParser alloc] init] parseSuccessfulResponse:response];
            if(!self.cancelled){
                [self searchArtistSongRequest:self.identifySongResponse.artist AndSong:self.identifySongResponse.song];
            }
		}
	}

}

@end
