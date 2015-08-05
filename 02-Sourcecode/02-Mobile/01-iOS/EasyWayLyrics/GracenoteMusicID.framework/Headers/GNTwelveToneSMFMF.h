//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "GNImage.h"

/**
 * Container class for 12Tone Data.
 */



@interface GNTwelveToneSMFMF : GNImage {
    
}


// Static instance constructor

/**
 * Contains the GN12ToneSMFMF metadata returned by an operation.
 */

+ (GNTwelveToneSMFMF*) gNTwelveToneSMFMF:(NSString*)inSize
                      data:(NSData*)inData
                  mimeType:(NSString*)inMimeType;

+ (GNTwelveToneSMFMF*) gNTwelveToneSMFMF:(NSString*)inUrl 
					  size:(NSString*)inSize;

@end
