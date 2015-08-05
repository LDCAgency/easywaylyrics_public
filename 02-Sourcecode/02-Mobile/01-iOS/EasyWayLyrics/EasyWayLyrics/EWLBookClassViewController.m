//
//  EWLBookClassViewController.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/1/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLBookClassViewController.h"

@interface EWLBookClassViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//For constraint layout handling
@property (weak, nonatomic) IBOutlet UIView *footerTransparentView;
@property (weak, nonatomic) IBOutlet UIView *footerWhiteView;
@property (weak, nonatomic) IBOutlet UILabel *footerBlackStripeLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation EWLBookClassViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];

}

-(void)viewWillAppear:(BOOL)animated{
    EWLBackgroundBlurImage *backgroundBlueImageSingleton = [EWLBackgroundBlurImage sharedInstance];
    
    if(backgroundBlueImageSingleton.albumBlurBackground){
        self.backgroundImageView.image = backgroundBlueImageSingleton.albumBlurBackground;
    }else{
        self.backgroundImageView.image = [UIImage imageNamed:@"common_background"];
    }

}

-(void) setupUI{
    [self.nameField setLeftPadding:20];
    [self.emailField setLeftPadding:20];
    [self.phoneField setLeftPadding:20];
}

#pragma mark - UITextFieldDelegate methods

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_GTE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 568.0f)

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (IS_IPHONE_GTE_5)
    {
        [self.scrollView setContentOffset:CGPointMake(0,150) animated:YES];
    }
    else if(IS_IPHONE)
    {
        if (textField == self.nameField)
        {
            [self.scrollView setContentOffset:CGPointMake(0,180) animated:YES];
        }
        else if (textField == self.emailField)
        {
            [self.scrollView setContentOffset:CGPointMake(0,200) animated:YES];
        }
        else if (textField == self.phoneField)
        {
            [self.scrollView setContentOffset:CGPointMake(0,220) animated:YES];
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.nameField)
    {
        [self.emailField becomeFirstResponder];
    }
    else if (textField == self.emailField)
    {
        [self.phoneField becomeFirstResponder];
    }
    else if (textField == self.phoneField)
    {
        [self touchUpSendButton:self];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}


#pragma mark - Actions
- (IBAction)touchUpSendButton:(id)sender {
    if([self.nameField.text isEqualToString:@""] || [self.emailField.text isEqualToString:@""] || [self.phoneField.text isEqualToString:@""])
    {
        UIAlertView *alert = [EWLAlertViewUtils buildAlertForMissingInformation];
        [alert show];
    }
    else if (![EWLStringUtils validateEmail:self.emailField.text])
    {
        UIAlertView *alert = [EWLAlertViewUtils buildAlertForInvalidEmail];
        [alert show];
    }else
    {
     [self insertContact];
    }
}
- (IBAction)touchUpScrollView:(id)sender {
    [self.view endEditing:YES];
    [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

#pragma mark - BaseNetworkDelegate

-(void) insertContact{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Sending ....";
    
    NSString *postData = [NSString stringWithFormat:@"name=%@&email=%@&phone=%@",self.nameField.text,self.emailField.text,self.phoneField.text];
    
    BaseNetworkRequest *insertContactRequest = [[BaseNetworkRequest alloc] init];
    [insertContactRequest setDelegate:self];
    [insertContactRequest setUrl:[NSURL URLWithString:[EWLConstants CONTACT_INSERT_SERVICE]]];
    [insertContactRequest setIdentifier:@"insertContactRequest"];
    [insertContactRequest startPostRequest:[postData dataUsingEncoding:NSUTF8StringEncoding]];
}

-(void)sucessOnRequest:(NSDictionary *)jsonArray AndIdentifier:(NSString *)identifier{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.nameField.text = @"";
    self.emailField.text = @"";
    self.phoneField.text = @"";
    
    UIAlertView* alert = [EWLAlertViewUtils buildAlertForContactSuccess];
    [alert show];
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
}

-(void) noConnectivity
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [EWLAlertViewUtils buildAlertForNoConnectivity];
    [alert show];
}


@end
