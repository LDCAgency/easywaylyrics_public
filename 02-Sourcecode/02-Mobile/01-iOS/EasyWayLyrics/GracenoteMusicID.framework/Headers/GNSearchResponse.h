//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

/**
 * Container class for the metadata returned by a match
 * generated from a recognition or search operation.
 *
 */

#import <Foundation/Foundation.h>

@class GNCoverArt;
@class GNImage;
@class GNDescriptor;
@class GNTwelveToneSMFMF;

@interface GNSearchResponse : NSObject {
@private
	NSString *m_albumTitle;
	NSString *m_albumTitleYomi;
	NSString *m_artist;
	NSString *m_artistYomi;
	NSString *m_albumArtist;
	NSString *m_albumArtistYomi;
	NSString *m_albumArtistBetsumei;
	NSString *m_artistBetsumei;
	NSString *m_trackTitle;
	NSString *m_trackTitleYomi;
	GNCoverArt *m_coverArt;
	NSString *m_albumId;
	NSString *m_albumReleaseYear;

	NSInteger m_albumTrackCount;
	NSInteger m_trackNumber;
	NSString *m_trackId;

	// Array of GNDescriptor elements for Track.
	NSArray *m_trackGenre;
	// Array of GNDescriptor elements for Album.
	NSArray *m_albumGenre;

	// Array of GNDescriptor elements for Track.
	NSArray *m_mood;

	// Array of GNDescriptor elements for Track.
	NSArray *m_tempo;

	//Added parameters to support Origin, Era, Type.

	// Array of GNDescriptor elements for Track.
	NSArray *m_origin;
	// Array of GNDescriptor elements for Album.
	NSArray *m_albumOrigin;

	// Array of GNDescriptor elements for Track.
	NSArray *m_era;
	// Array of GNDescriptor elements for Album.
	NSArray *m_albumEra;

	// Array of GNDescriptor elements for Track.
	NSArray *m_artistType;
	// Array of GNDescriptor elements for Album.
	NSArray *m_albumArtistType;


	// Array of GNLinkData* elements
	NSArray *m_albumLinkData;
	NSArray *m_trackLinkData;

	NSArray *m_albumReview;
	NSArray *m_artistBiography;

	NSString *m_songPosition;

	NSString *m_artistImageURLTemp;
	NSData *m_artistImageData;

    //MSDK-1735, To expose urls.
    NSString *m_artistBiographyUrl;
	NSString *m_artistBiographyString;

    //MSDK-1735, To expose urls.
    NSString *m_albumReviewUrl;
	NSString *m_albumReviewString;


	//Added for Normalizing GNImage.
    GNImage *m_contributorImage;
    GNImage *m_gnImage;

    //MSDK-1861, To get 12Tone data.
    GNTwelveToneSMFMF *m_twelveToneSMFMF;

    BOOL m_partial;

    NSString * m_language;
}

/**
 * Returns true if response is partial, false otherwise.
 */
@property(nonatomic,readonly) BOOL partial;

/**
 * Title of the album.
 */
@property (nonatomic, copy) NSString *albumTitle;
/**
 * Japanese phonetic representation of the album title.
 */
@property (nonatomic, copy) NSString *albumTitleYomi;
/**
 * Name of the artist.
 */
@property (nonatomic, copy) NSString *artist;
/**
 * Japanese phonetic representation of the artist name.
 */
@property (nonatomic, copy) NSString *artistYomi;
/**
 * Name of the album artist.
 */
@property (nonatomic, copy) NSString *albumArtist;
/**
 * Japanese phonetic representation of the album artist name.
 */
@property (nonatomic, copy) NSString *albumArtistYomi;
/**
 * Japanese alternate names and pronunciations for album artist name.
 */
@property (nonatomic, copy) NSString *albumArtistBetsumei;
/**
 * Japanese alternate names and pronunciations for artist name.
 */
@property (nonatomic, copy) NSString *artistBetsumei;
/**
 * Title of the track.
 */
@property (nonatomic, copy) NSString *trackTitle;
/**
 * Japanese phonetic representation of the track title.
 */
@property (nonatomic, copy) NSString *trackTitleYomi;
/**
 * Album cover art.
 */
@property (nonatomic, retain) GNCoverArt *coverArt;
/**
 * Gracenote unique identifier for the album.
 */
@property (nonatomic, copy) NSString *albumId;
/**
 * Year the album was released.
 */
@property (nonatomic, copy) NSString *albumReleaseYear;
/**
 * Number of tracks on the album. Note that albumTrackCount will be -1
 * if the value passed to gNSearchResponse is nil.
 */
@property (nonatomic, assign) NSInteger albumTrackCount;
/**
 * One-based index of the track on the album. Note that trackNumber will be -1
 * if the value passed to gNSearchResponse is nil.
 */
@property (nonatomic, assign) NSInteger trackNumber;
/**
 * Gracenote unique identifer for the track
 */
@property (nonatomic, retain) NSString *trackId;
/**
 * Language for the track
 */
@property (nonatomic, retain) NSString *language;
/**
 * Collection of genres for the track.
 */
@property (nonatomic, copy) NSArray *trackGenre;
/**
 * Collection of genres for the album.
 */
@property (nonatomic, copy) NSArray *albumGenre;
/**
 * Link identifiers related to the album.
 */
@property (nonatomic, copy) NSArray *albumLinkData;
/**
 * Link identifiers related to the track.
 */
@property (nonatomic, copy) NSArray *trackLinkData;
/**
 * Album review.
 */
@property (nonatomic, copy) NSArray *albumReview;
/**
 * Artist's biography.
 */
@property (nonatomic, copy) NSArray *artistBiography;

/**
 * Returns song position in milliseconds for the track identified by the
 * response.
 */
@property (nonatomic, copy) NSString *songPosition;

/**
 * Returns adjusted song position in milliseconds for the track identified by the
 * response.
 */
@property (nonatomic, copy, readonly) NSString *adjustedSongPosition;

/**
 * Collection of moods for the track.
 */
@property (nonatomic, copy) NSArray *mood;
/**
 * Collection of moods for the album.
 */

/**
 * Collection of tempos for the track.
 */
@property (nonatomic, copy) NSArray *tempo;

/**
 * GNImage for Contributor Image
 */
@property (nonatomic, copy) GNImage *contributorImage;

//Added parameters to support Artist Origin, Era, Atype.

/**
 * Collection of origin for the track.
 */
@property (nonatomic, copy) NSArray *origin;

/**
 * Collection of era for the track.
 */
@property (nonatomic, copy) NSArray *era;


/**
 * Collection of artist type for the track.
 */
@property (nonatomic, copy) NSArray *artistType;

/**
 * URL for the artist biography.
 * If there is no artist biography, the string is set to nil.
 *
 * Note: Enriched content URLs are temporary; therefore, the application must be configured
 * to handle expired URLs. Please contact your Gracenote Professional Services representative
 * to discuss best practices for temporary caching and error handling.
 */
@property (nonatomic, copy) NSString *artistBiographyUrl;

/**
	* URL for the album review.
	* If there is no album review, the string is set to nil.
	*
	* Note: Enriched content URLs are temporary; therefore, the application must be configured
	* to handle expired URLs. Please contact your Gracenote Professional Services representative
	* to discuss best practices for temporary caching and error handling.
	*
	*/
@property (nonatomic, copy) NSString *albumReviewUrl;


@property (nonatomic, retain) GNTwelveToneSMFMF *twelveToneSMFMF;

/**
 * Returns track duration in milliseconds for the track identified by the
 * response.
 */
@property(readonly) NSString *trackDuration;

@end
