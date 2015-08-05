//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

/**
 * Container class for Link data. 
 * Link data can be used to access additional content from third-party catalogs; for example, providing
 * the user an opportunity to purchase audio matched via an audio recognition operation.
 */
#import <Foundation/Foundation.h>


@interface GNLinkData : NSObject {
	@private
	NSString *m_source;
	NSString *m_uid;
}

/**
 * The name of the Link data provider.
 * 
 */

@property (nonatomic, copy) NSString *source;

/**
 * The Link identifier. The Link identifier is a specific
 * value that associates the Link provider with the data returned
 * by the associated operation. The Link identifier is used to 
 * access data or services provided by the Link provider when an
 * affiliate agreement is in place.
 */

@property (nonatomic, copy) NSString *uid;

/**
 * Contains the GNLinkData metadata returned by a operation.
 */

+ (GNLinkData*) gNLinkData:(NSString*)source uid:(NSString*)uid;

@end
