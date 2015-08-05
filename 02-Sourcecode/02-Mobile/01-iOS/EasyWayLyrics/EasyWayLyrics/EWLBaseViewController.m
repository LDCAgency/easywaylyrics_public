//
//  EWLBaseViewController.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 3/28/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLBaseViewController.h"

@interface EWLBaseViewController ()

@end

@implementation EWLBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UI methods
-(void) switchNavigationBarVisibility:(BOOL) onOff
{
    self.navigationController.navigationBarHidden = !onOff;
}

#pragma mark - Sharing methods

-(void) openShareSheet:(NSString*) textToShare
{
    NSArray *activityItems = @[textToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeCopyToPasteboard];
    [self presentViewController:activityVC animated:YES completion:nil];
}

-(void) openShareSheet:(NSString*) textToShare AnsImage:(UIImage*) imageToShare
{
    NSArray *activityItems = @[textToShare, imageToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeCopyToPasteboard];
    [self presentViewController:activityVC animated:YES completion:nil];
}



@end
