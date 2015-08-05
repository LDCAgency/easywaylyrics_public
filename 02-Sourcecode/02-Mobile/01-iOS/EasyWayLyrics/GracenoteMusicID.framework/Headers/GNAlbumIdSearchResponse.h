//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2011. All rights reserved.
//

/**
 * Container class for the metadata returned by a match 
 * generated from an AlbumId operation. Subclass of GNSearchResponse.
 *
 */

#import <Foundation/Foundation.h>
#import "GNSearchResponse.h"

@interface GNAlbumIdSearchResponse : GNSearchResponse 
{
	@private
	NSString *m_fileIdent;
}

/**
 * The unique identifier of the file for which a match was found. 
 * This will contain the same value as the corresponding GNAlbumIdAttributes object.
 */
@property(nonatomic, retain) NSString *fileIdent;



@end
