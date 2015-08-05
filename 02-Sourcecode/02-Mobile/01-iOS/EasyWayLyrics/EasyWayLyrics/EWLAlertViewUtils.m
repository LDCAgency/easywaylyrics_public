//
//  EWLAlertViewUtils.m
//  EasyWayLyrics
//
//  Created by Paulo Almeida on 4/1/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "EWLAlertViewUtils.h"

@implementation EWLAlertViewUtils

+(UIAlertView*) buildAlertForNoConnectivity
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                    message:@"You must be connected to the internet to use this app."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForErrorRequest
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops."
                                                    message:@"Something went wrong, please try again later."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForSongNotFoundRequest
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops."
                                                    message:@"Lyrics not found for this song.\nMaybe try another one? :)"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForMissingInformation
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing information"
                                                    message:@"You must fill in all information in order to proceed"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForInvalidEmail
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid email"
                                                    message:@"You must provide a valid email address in order to proceed"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForMinCharacters:(int) number
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not enough content"
                                                    message:[NSString stringWithFormat:@"This field needs at least %d characters in order to proceed",number]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForContactSuccess
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you"
                                                    message:@"We'll get back to you shortly"
                                                   delegate:nil
                                          cancelButtonTitle:@"Continue"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForNoSynchronizedLyrics
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No sync data for this song :("
                                                    message:@"We have over 372,000 synchronized lyrics but this is not one of them. Sorry."
                                                   delegate:nil
                                          cancelButtonTitle:@"Continue"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForMissingSongInformation
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                    message:@"The song you've chosen doesn't provide the minimal metadata information."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForNotIdentifiedSong
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                    message:@"We couldn’t find a match.\nGet close to the sound."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    return alert;
}

+(UIAlertView*) buildAlertForNotIdentifiedSongLibrary
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                    message:@"We couldn’t find a match."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    return alert;
}


@end
