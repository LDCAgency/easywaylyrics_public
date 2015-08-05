//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

// Now All things are moved to GNImage as we need to Normalize the image object for coverArt and artist Image.

#import <Foundation/Foundation.h>
#import "GNImage.h"

/**
 * Container class for album cover art.
 */
@interface GNCoverArt : GNImage {

}


// Static instance constructor

/**
 * Contains the GNCoverArt metadata returned by an operation.
 */

+ (GNCoverArt*) gNCoverArt:(NSString*)inSize
                      data:(NSData*)inData
                  mimeType:(NSString*)inMimeType;

+ (GNCoverArt*) gNCoverArt:(NSString*)inUrl 
					  size:(NSString*)inSize;



@end
