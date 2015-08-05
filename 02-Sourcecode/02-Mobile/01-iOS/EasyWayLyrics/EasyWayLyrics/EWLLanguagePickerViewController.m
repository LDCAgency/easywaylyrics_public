//
//  EWLLanguagePickerViewController.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/16/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLLanguagePickerViewController.h"

@interface EWLLanguagePickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *languagesPickerView;
@property(nonatomic,strong) NSArray *countryNames;
@property(nonatomic,strong) NSArray *twoLettersCountries;
@end

@implementation EWLLanguagePickerViewController

NSString *returnValue;

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [self setupUI];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.selectedLanguage){
        #ifdef DEBUG
            NSLog(@"%s indexOf:%lu",__PRETTY_FUNCTION__,(unsigned long)[self.twoLettersCountries indexOfObject:self.selectedLanguage]);
        #endif
        [self.languagesPickerView selectRow:[self.twoLettersCountries indexOfObject:self.selectedLanguage] inComponent:0 animated:YES];
    }
}

-(void) setupUI{
    self.twoLettersCountries = [EWLConstants TWO_LETTERS_COUNTRIES];
    self.countryNames = [EWLConstants COUNTRY_NAMES];
}

#pragma mark - Actions

- (IBAction)touchUpOutsideBlackboxArea:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.delegate && returnValue){
            [self.delegate didSelectALanguage:returnValue];
        }else if(self.delegate){
            [self.delegate gaveUpSelectingALanguage];
        }
    }];
}


#pragma mark - UIPickerViewDelegate methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.countryNames count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.countryNames objectAtIndex:row];
}

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = [self.countryNames objectAtIndex:row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    returnValue = [self.twoLettersCountries objectAtIndex:row];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
