//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2011. All rights reserved.
//

/**
 * Container class for the errors that can occur in AlbumId operations.  
 *
 */

#import <Foundation/Foundation.h>


@interface GNAlbumIdFileError : NSObject {
	@private
	NSString *m_errMessage;
	NSString *m_errCode;
	NSString *m_fileIdent;
}
/**
 * The message indicating the reason for the error. This might contain multiple reasons separated by ",".
 */
@property(nonatomic,retain) NSString *errMessage;
/**
 * The code for the error. The default value is a blank string.
 */
@property(nonatomic,retain) NSString *errCode;
/**
 * The unique identifier for the file for which the error occurred. 
 * This will contain the same value as the corresponding GNAlbumIdAttributes object.
 */
@property(nonatomic,retain) NSString *fileIdent;

// Static instance constructor
/**
 * Returns the GNAlbumIdFileError object.
 */


+(GNAlbumIdFileError *) gNAlbumIdFileError:(NSString *)fileIndent 
								 errorCode:(NSString *)errCode 
							  errorMessage:(NSString *)errMessage;
@end
