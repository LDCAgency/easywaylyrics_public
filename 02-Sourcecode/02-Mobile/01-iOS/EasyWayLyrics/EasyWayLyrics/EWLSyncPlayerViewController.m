//
//  EWLSyncPlayerViewController.m
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 5/1/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLSyncPlayerViewController.h"

@interface EWLSyncPlayerViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *artworkAlbumImage;
@property (weak, nonatomic) IBOutlet UIButton *changeLanguageButton;
@property (weak, nonatomic) IBOutlet UILabel *fromLanguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditsLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *creditsScrollView;
@property (weak, nonatomic) IBOutlet UILabel *albumCoverFromItunes;

//Sync Lyrics
@property (weak, nonatomic) IBOutlet UIView *syncLyricsBlackBox;
@property (weak, nonatomic) IBOutlet UILabel *syncLyricsLabel;

//Not Sync Lyrics
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewNotSyncLyrics;
@property (weak, nonatomic) IBOutlet UILabel *notSyncLyricsLabel;
@property (weak, nonatomic) IBOutlet UIView *notSyncLyricsBlackBox;


@property (strong,nonatomic) NSTimer* timerPlayingMusic;
@property(nonatomic) float currentTimeInSeconds;

@end

@implementation EWLSyncPlayerViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

-(void) setupUI{
    if([self.baseResponse isKindOfClass:[EWLSearchArtistSongLyricWithoutLyricsResponse class]]){
        UIAlertView* alertView = [EWLAlertViewUtils buildAlertForNoSynchronizedLyrics];
        [alertView show];
    }
    //Setting Song name at title bar
    self.navigationItem.title = self.identifySongResponse.song;
    [self processBaseResponse];
    
    //Adding Notifications for when use suddently puts it on background for some reason
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationResignedActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void) processBaseResponse{
    
    [self.changeLanguageButton setTitle: [[EWLConstants COUNTRY_NAMES] objectAtIndex:[[EWLConstants TWO_LETTERS_COUNTRIES] indexOfObject:self.baseResponse.translated_to_lang]] forState:UIControlStateNormal] ;
    
    //TODO - Use i18n archive to get that string
    self.fromLanguageLabel.text = [NSString stringWithFormat:@"from %@ to",[[EWLConstants COUNTRY_NAMES] objectAtIndex:[[EWLConstants TWO_LETTERS_COUNTRIES] indexOfObject:self.baseResponse.predominant_language]]];
    
    //Hiding things until we get they are really necessary
    if([self.baseResponse isKindOfClass:[EWLSearchArtistSongLyricWithoutLyricsResponse class]]){
        self.syncLyricsBlackBox.hidden = YES;
        self.syncLyricsLabel.hidden = YES;
        
        
        EWLSearchArtistSongLyricWithoutLyricsResponse* response = ((EWLSearchArtistSongLyricWithoutLyricsResponse*)self.baseResponse);
        
        NSArray *dataLyrics = [response.lyrics componentsSeparatedByString:CARRIAGE_RETURN] ;
        NSArray *dataOriginal  = [response.original componentsSeparatedByString:CARRIAGE_RETURN];
        
        NSMutableAttributedString *mixedString = [[NSMutableAttributedString alloc] initWithString:@""];
        
        for (int i = 0; i < [dataLyrics count]; i++)
        {
            NSString *text = [dataOriginal objectAtIndex:i];
            if(![text isEqualToString:@""])
            {
                
                NSMutableAttributedString *originalStr = [[NSMutableAttributedString alloc] initWithString:text];
                [originalStr setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Courier" size:13], NSForegroundColorAttributeName:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]} range:[text rangeOfString:text]];
                [mixedString appendAttributedString:originalStr];
                
                [mixedString appendAttributedString:[[NSAttributedString alloc] initWithString:CARRIAGE_RETURN]];
                [mixedString appendAttributedString:[[NSAttributedString alloc] initWithString:[dataLyrics objectAtIndex:i]]];
                [mixedString appendAttributedString:[[NSAttributedString alloc] initWithString:CARRIAGE_RETURN]];
                [mixedString appendAttributedString:[[NSAttributedString alloc] initWithString:CARRIAGE_RETURN]];
            }
        }
        
        self.notSyncLyricsLabel.attributedText = mixedString;
    }else{
        self.scrollViewNotSyncLyrics.hidden = YES;
        self.notSyncLyricsBlackBox.hidden = YES;
        self.notSyncLyricsLabel.hidden = YES;
    }
     self.creditsLabel.text = [NSString stringWithFormat:@"Copyright: %@\r\n\r\nWriter: %@",self.baseResponse.copyright,self.baseResponse.writer];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startMusicPlaying];
#ifdef DEBUG
    NSLog(@"%s Date difference: %f",__PRETTY_FUNCTION__,[[NSDate date] timeIntervalSinceDate: self.dateStartedSync]);
    NSLog(@"%s identifySongResponse: %d",__PRETTY_FUNCTION__,self.identifySongResponse.matchedPosition);
#endif
    self.currentTimeInSeconds = (self.identifySongResponse.matchedPosition / 1000) + 1 + floor([[NSDate date] timeIntervalSinceDate: self.dateStartedSync]);
    self.timerPlayingMusic =[NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timeInteration:) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.timerPlayingMusic invalidate];
}

#pragma mark - Recording interrurpt handler

- (void) applicationResignedActive:(NSNotification *)notification {
#ifdef DEBUG
    NSLog(@"%s",__PRETTY_FUNCTION__);
#endif
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

#pragma mark - Actions

- (IBAction)touchUpNavShareButton:(id)sender {
    [self openShareSheet:[EWLConstants TEXT_SHARE]];
}

- (IBAction)touchUpLanguagePickerButton:(id)sender {
    EWLLanguagePickerViewController* ewlLanguagePickerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EWLLanguagePickerViewController"];
    ewlLanguagePickerViewController.selectedLanguage = self.baseResponse.translated_to_lang;
    ewlLanguagePickerViewController.delegate = self;
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:ewlLanguagePickerViewController animated:YES completion:nil];
    
}
- (IBAction)touchUpLyricsCreditsButton:(id)sender {
    self.creditsScrollView.hidden = !self.creditsScrollView.hidden;
    if (self.creditsScrollView.hidden) {
        [((UIButton*)(sender)) setTitle:@"Lyrics credits" forState:UIControlStateNormal];
    }else{
        [((UIButton*)(sender)) setTitle:@"Close credits" forState:UIControlStateNormal];
    }
}
- (IBAction)touchUpReSyncButton:(id)sender {
    if(self.delegate){
        [self.delegate reSyncMusic];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma mark - UI methods

-(void) startMusicPlaying
{
    //Checking if we haven't downloaded it using Itunes AlbumArtwork API
    UIImage *imageArtWork = nil;
    if(self.itunesAlbumArtworkImage){
        imageArtWork = self.itunesAlbumArtworkImage;
        self.albumCoverFromItunes.hidden = NO;
    }
    
    // Setting a image with blur filter applied throughout this app
    EWLBackgroundBlurImage *backgroundBlueImageSingleton = [EWLBackgroundBlurImage sharedInstance];
    if(imageArtWork){
        backgroundBlueImageSingleton.albumBlurBackground = [imageArtWork applyBlurWithRadius:20.0f tintColor:nil saturationDeltaFactor:1.0f maskImage:nil];
        
        self.artworkAlbumImage.image = imageArtWork;
        self.backgroundImageView.image = backgroundBlueImageSingleton.albumBlurBackground;
        
    }else{
        backgroundBlueImageSingleton.albumBlurBackground = nil;
    }
}

-(void) timeInteration:(NSTimer *)timer{
    self.currentTimeInSeconds= self.currentTimeInSeconds+0.5f;
    if([self.baseResponse isKindOfClass:[EWLSearchArtistSongLyricWithLyricsResponse class]])
    {
        NSString *preChosenLine = @"";
        
        EWLSearchArtistSongLyricWithLyricsResponse *response = (EWLSearchArtistSongLyricWithLyricsResponse*)self.baseResponse;
        for(int i=0; i < [response.lrc count];i++){
            EWLSearchArtistSongLyricWithLyricsItem* item = [response.lrc objectAtIndex:i];
            if(![item.line isEqualToString:@""])
            {
                if(item.milliseconds <= self.currentTimeInSeconds*1000)
                {
                    preChosenLine = item.line;
                }
                else
                {
                    break;
                }
            }
        }
#ifdef DEBUG
        NSLog(@"Time : %f Lyrics: %@",self.currentTimeInSeconds*1000,preChosenLine);
#endif
        if(![self.syncLyricsLabel.text isEqualToString:preChosenLine]){
            if(self.syncLyricsBlackBox.hidden == YES){
                self.syncLyricsBlackBox.hidden = NO;
            }
            self.syncLyricsLabel.text = preChosenLine;
        }
    }
    
}

#pragma mark - EWLLanguagePickerViewControllerDelegate methods

-(void)gaveUpSelectingALanguage{
#ifdef DEBUG
    NSLog(@"%s",__PRETTY_FUNCTION__);
#endif
}

-(void)didSelectALanguage:(NSString *)twoLettersLanguage{
#ifdef DEBUG
    NSLog(@"%s %@",__PRETTY_FUNCTION__,twoLettersLanguage);
#endif
    [self searchLyrics:self.identifySongResponse.artist AndSong:self.identifySongResponse.song AndToLang:twoLettersLanguage];
}

#pragma mark - BaseNetworkDelegate

-(void) searchLyrics:(NSString*) artist AndSong:(NSString*) song AndToLang:(NSString*) language{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Translating Lyrics ....";
    
    BaseNetworkRequest *searchArtistSongRequest = [[BaseNetworkRequest alloc] init];
    [searchArtistSongRequest setDelegate:self];
    [searchArtistSongRequest setUrl:[NSURL URLWithString:[EWLConstants SEARCH_LYRICS_SERVICE:artist AndSong:song AndToLang:language]]];
    [searchArtistSongRequest setIdentifier:@"searchArtistSongRequest"];
    [searchArtistSongRequest startGetRequest];
}

-(void)sucessOnRequest:(NSDictionary *)jsonArray AndIdentifier:(NSString *)identifier{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if([identifier isEqualToString:@"searchArtistSongRequest"])
    {
        self.baseResponse = [[[EWLSearchSongByArtistJSONParser alloc]init] parseSuccessfulResponse:jsonArray];
        [self processBaseResponse];
    }
}

-(void) errorOnRequest:(NSString *)identifier
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [EWLAlertViewUtils buildAlertForErrorRequest];
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

-(void) noConnectivity
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [EWLAlertViewUtils buildAlertForNoConnectivity];
    [alert show];
}


@end
