//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2011. All rights reserved.
//

/**
 * Container class for the metadata fetched from 
 * a file for AlbumId operations.
 */

#import <Foundation/Foundation.h>


@interface GNAlbumIdAttributes : NSObject 
{
	@private
	NSString *m_filePath;
	NSString *m_artist;
	NSString *m_albumTitle;
	NSString *m_trackTitle;
	NSString *m_trackNumber;
	NSString *m_gnId;
	NSString *m_fingerPrintData;
	NSString *m_identifier;
	NSString *m_genre;
@private
	NSMutableString *m_errorMsg;
}

/**
 * The path of the file. This can be nil in the case of an albumIdList operation.
 */
@property(nonatomic, retain) NSString *filePath;
/**
 * The artist name of the track to be identified.
 */
@property(nonatomic, retain) NSString *artist;
/**
 * The album title of the track to be identified.
 */
@property(nonatomic, retain) NSString *albumTitle;
/**
 * The title of the track to be identified.
 */
@property(nonatomic, retain) NSString *trackTitle;
/**
 * The index of the track in the album.
 */
@property(nonatomic, retain) NSString *trackNumber;
/**
 * The Gracenote ID of the track to be identified.
 */
@property(nonatomic, retain) NSString *gnId;
/**
 * The fingerprint as a string.
 */
@property(nonatomic, retain) NSString *fingerPrintData;
/**
 * The unique identifier for the multiple track response. This cannot be nil.
 * The value of this property will be filePath for albumIdDirectory and albumIdFile operations, 
 * or will be provided by the application developer for an albumIdList operation.
 */
@property(nonatomic, retain) NSString *identifier;
/**
 * The genre of the track to be identified.
 */
@property(nonatomic, retain) NSString *genre;

// Static instance constructor
/**
 * Returns the GNAlbumIdAttributes object.
 */

+(GNAlbumIdAttributes *) gNAlbumIdAttributes:(NSString *)filePath 
								  identifier:(NSString *)identifier
								  albumTitle:(NSString *)albumTitle 
								  trackTitle:(NSString *)trackTitle 
								 trackNumber:(NSString *)trackNumber 
									   genre:(NSString *)genre
									  artist:(NSString *)artist 
										gnId:(NSString *)gnId;

+(GNAlbumIdAttributes *) gNAlbumIdAttributes:(NSString *)filePath 
								  identifier:(NSString *)identifier
								  albumTitle:(NSString *)albumTitle 
								  trackTitle:(NSString *)trackTitle 
								 trackNumber:(NSString *)trackNumber 
									   genre:(NSString *)genre
									  artist:(NSString *)artist 
										gnId:(NSString *)gnId 
							 fingerPrintData:(NSString *)fingerPrintData;

@end
