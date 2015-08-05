//
//  EWLBaseViewController.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 3/28/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWLBaseViewController : UIViewController
#pragma mark - UI methods
-(void) switchNavigationBarVisibility:(BOOL) onOff;

#pragma mark - Sharing methods
-(void) openShareSheet:(NSString*) textToShare;
-(void) openShareSheet:(NSString*) textToShare AnsImage:(UIImage*) imageToShare;

@end
