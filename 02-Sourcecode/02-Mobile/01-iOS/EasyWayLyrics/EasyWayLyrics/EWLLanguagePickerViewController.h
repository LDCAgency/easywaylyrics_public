//
//  EWLLanguagePickerViewController.h
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/16/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLBaseViewController.h"

@protocol EWLLanguagePickerViewControllerDelegate <NSObject>

-(void) gaveUpSelectingALanguage;
-(void) didSelectALanguage:(NSString*) twoLettersLanguage;

@end

@interface EWLLanguagePickerViewController : EWLBaseViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong) NSString* selectedLanguage;

@property(nonatomic,strong) id<EWLLanguagePickerViewControllerDelegate> delegate;

@end
