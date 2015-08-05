//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2011. All rights reserved.
//

/**
 * Container class for all responses generated from AlbumId operations. 
 */

#import <Foundation/Foundation.h>
#import "GNSearchResult.h"

@interface GNAlbumIdSearchResult : GNSearchResult 
{
	@private
	NSMutableArray *m_noMatchResponses;
	NSMutableArray *m_errorResponses;
}

/**
 * Array of NSString objects containing file identifiers
 * for files for which no match was returned.
 * Note that in the case when all files are matched,
 * an empty array is returned, so that user code can
 * always iterate over the responses with a
 * "for each" iterator, without having to check
 * for the null responses case.
 */
@property(nonatomic,retain,readonly) NSMutableArray *noMatchResponses;

/** 
 * Array of GNAlbumIdFileError objects.
 * This array will contain errors for
 * files for which AlbumId look-up could not be requested,
 * and files for which an error is returned.
 * Note that in the case of no errors, 
 * an empty array is returned, so that user code can
 * always iterate over the responses with a
 * "for each" iterator without having to check
 * for the null responses case.
 */
@property(nonatomic,retain,readonly) NSMutableArray *errorResponses;


@end
