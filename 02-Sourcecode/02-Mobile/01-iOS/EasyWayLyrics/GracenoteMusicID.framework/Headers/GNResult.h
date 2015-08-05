//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GNSearchResponse;
@class GNConfig;

/**
 * Container class for returning the result of an operation to the
 * application. 
 * This class contains the common result fields; specific operations return
 * result classes that extend this class with specific result fields.
 * Status and error codes are provided to describe the result of the
 * associated operation. For example, when a text search operation successfully
 * executes without error, but no match is found, the result object
 * reports an error of "NoError" and a status of "WSTextSearchNoMatchStatus." 
 */
@interface GNResult : NSObject {
@private
  int m_errCode;
  NSString *m_errMessage;
  int m_statusCode;
  GNConfig *m_config;
}

@property (nonatomic, assign) int errCode;
@property (nonatomic, copy) NSString *errMessage;
@property (nonatomic, assign) int statusCode;
@property (nonatomic, retain) GNConfig *config;

// getter/setter for public instance properties
//
// failure : boolean
//   true when any error caused an operation to fail
// errMessage : string
//   failure message that describes the specific problem
// errCode : int
//   set to a specific well known error code
// config : GNConfig instance
//   the specific config object used for this operation (typically default config)
// isAnyFingerprintFailure : boolean
//   true when any error during recording/fingerprinting is encountered
// recordingFailure : boolean
//   true when recording from microphone failed
// fingerprintingFailure : boolean
//   true when creating a fingerprint failed
// FPXTimeoutFailure : boolean
//   true when recording/fingerprinting operation timed out
// anyWebservicesFailure : boolean
//   true when any webservices error is encountered
// networkFailure : boolean
//   true when webservices could not be contacted due to a network error
// invalidDataFormatFailure : bool
//   true when webservices fails due to invalid data being sent or received
// webservicesTimeoutFailure : bool
//   true when webservices fails because a network operation took too long
// isFingerprintSearchNoMatchStatus : bool
//   true when webservices was unable to match a valid fingerprint
// isTextSearchNoMatchStatus : bool
//   true when webservices was unable to match a text search
// isAlbumFetchNoMatchStatus : bool
//   true when webservices was unable to match a album fetch
// isLyricFragmentSearchNoMatchStatus : bool
//   true when webservices was unable to match a lyric search

/**
 * Returns true when the associated operation fails for any reason.
 * @return True when any failure occurs. False otherwise. 
 */

- (BOOL) isFailure;

/**
 * Returns true when the associated operation fails due to any error occurring
 * while generating a fingerprint.
 * @return True when fingerprint generation error occurs. False otherwise.
 */

- (BOOL) isAnyFingerprintFailure;

/**
 * Returns true when the associated operation fails because the microphone
 * is not accessible, or recording from the microphone is interrupted.
 * @return True when recording error occurs. False otherwise.
 */

- (BOOL) isRecordingFailure;

/**
 * Returns true when the associated operation fails because a fingerprint
 * is not successfully generated from an audio sample.
 * @return True when fingerprint cannot be generated. False otherwise.
 */

- (BOOL) isFingerprintingFailure;

/**
 * Returns true when the associated operation fails because a FPX
 * is not successfully generated from an audio sample.
 * @return True when FPX cannot be generated. False otherwise.
 */

- (BOOL) isFPXTimeoutFailure;

/**
 * Returns true when the associated operation fails due to any Web Services
 * error.
 * @return True when Web Services error occurs. False otherwise.
 */

- (BOOL) isAnyWebservicesFailure;

/** 
 * Returns true when the associated operation fails because the device is
 * not connected to a network or a network send/receive error occurred.
 * @return True when network error occurs. False otherwise.
 */

- (BOOL) isNetworkFailure;

/**
 * Returns true when Web Services returns data in an unexpected format.
 * @return True when data received in unexpected format. False otherwise.
 */

- (BOOL) isInvalidDataFormatFailure;

/**
 * Returns true when Web Services fails due to a timeout.
 * @return True when Web Services fails due to a timeout. False otherwise.
 */

- (BOOL) isWebservicesTimeoutFailure;

/**
 * Returns true when the associated search operation is successful, but 
 * no match is found.
 * @return True when search successful but no match found. False otherwise.
 */

- (BOOL) isAnySearchNoMatchStatus;

/**
 * Returns true when the associated fingerprint search operation is 
 * successful, but no match is found.
 * @return True when fingerprint search successful but no match found.
 * False otherwise.
 */

- (BOOL) isFingerprintSearchNoMatchStatus;

/**
 * Returns true when the associated text search operation is successful, but
 * no match is found.
 * @return True when text search successful but no match found.
 * False otherwise.
 */

- (BOOL) isTextSearchNoMatchStatus;
/**
 * Returns true when the associated lyric fragment search operation is
 * successful, but no match is found.
 * @return True when lyric fragment search successful but no match found.
 * False otherwise.
 */
- (BOOL) isLyricFragmentSearchNoMatchStatus;

/**
 * Returns true when the associated Album fetch operation is
 * successful, but no match is found.
 * @return True when Album fetch is successful but no match found.
 * False otherwise.
 */
- (BOOL) isAlbumFetchNoMatchStatus;

/**
 * Returns true when the associated AlbumId lookup operation is
 * successful, but errors are found for a subset of files.
 * @return True when AlbumId lookup is successful but errors are found for a subset of files.
 * False otherwise.
 */
- (BOOL) isAlbumIdPartialFailure;

/** 
 * Returns true when the AlbumId lookup operation fails for any reason.
 * @return True when any failure occurs. False otherwise. 
 */
- (BOOL) isAlbumIdFailure;

/**
 * Returns true when the associated AlbumId lookup operation is
 * successful, but no match is found.
 * @return True when AlbumId lookup successful but no match found.
 * False otherwise.
 */
- (BOOL) isAlbumIdNoMatchStatus;

/**
 * Returns true when the associated operation fails because a operation
 * timedout.
 * @return True when operation is timed out. False otherwise.
 */

- (BOOL) isOpTimeoutFailure;


// Public properties defined on the class GNResult,
// for example GNResult.NoError

// errCode value when no error.

/**
 * An Operation failure occurred due to a timeout.
 */

+ (int) OpTimeoutFailure;

/**
 * No error occurred.
 */
+ (int) NoError;

// errCode value when an unhandled error condition was encountered.

/**
 * An unhandled error condition was encountered.
 */
+ (int) UnhandledError;

// errCode for generic fingerprinter error

/**
 * A failure occurred while generating a fingerprint.
 */

+ (int) FPXFailure;

/**
 * A failure occurred while trying to generate a fingerprint for an audio sample.
 */
+ (int) FPXNotMusic;

// errCode when microphone can't be accessed or recording was interrupted.

/**
 * The microphone can't be accessed or recording from the microphone 
 * was interrupted.
 */

+ (int) FPXRecordingFailure;

// errCode when fingerprinting of PCM failed.

/**
 * A failure occurred while trying to generate a fingerprint for an audio sample.
 */

+ (int) FPXFingerprintingFailure;

// errCode for case where record/fingerprint failed because of a timeout

/**
 * A fingerprint failure occurred due to a timeout.
 */

+ (int) FPXTimeoutFailure;

// errCode for generic webservices error

/**
 * A error occurred while contacting Web Services.
 */

+ (int) WSFailure;

// errCode for case where network is inaccessable or send/receive failed

/**
 * The device is not connected to a network or there was a network
 * communication error.
 */

+ (int) WSNetworkFailure;

// errCode for case where webservices returns data in an unexpected format.

/**
 * Web Services returned data in an unexpected format.
 */

+ (int) WSInvalidDataFormatFailure;

// errCode for case where webservices registration failed due to an invalid clientId.

/**
 * Web Services registration failed due to an invalid Client Id.
 */

+ (int) WSRegistrationInvalidClientIdFailure;

// errCode for case where webservices failed because the network operation timed out.

/**
 * Web Services communication failed due to timeout.
 */

+ (int) WSTimeoutFailure;

// value for statusCode when there is no specific status.

/**
 * No specific status data available.
 */

+ (int) NoStatus;

// value that indicates a fingerprint search worked, but did not generate a match.

/**
 * The associated fingerprint search operation was successful, but no match was found.
 */

+ (int) WSFingerprintSearchNoMatchStatus;

// value that indicates a text search worked, but did not generate a match.

/**
 * The associated text search operation was successful, but no match was found.
 */

+ (int) WSTextSearchNoMatchStatus;

// value that indicates a album fetch worked, but did not generate a match.

/**
 * The associated Album Id fetch operation was successful, but no match was found.
 */

+ (int) WSAlbumFetchNoMatchStatus;

// value that indicates a lyric fragment search worked, but did not generate a match.

/**
 * The associated lyric fragment search operation was successful, but no match was found.
 */

+ (int) WSLyricFragmentSearchNoMatchStatus;

// value that indicates a AlbumId lookup successful, but did not generate a match.

/**
 * The associated AlbumId lookup operation was successful, but no match was found.
 */
+ (int) AlbumIdNoMatchStatus;

// value that indicates albumId lookup operation has failed for any reason. 

/**
 * The associated AlbumId lookup operation failed.
 */
+ (int) AlbumIdFailure;

// value that indicates albumId lookup operation was successful but found no match for few files. 

/**
 * The associated AlbumId lookup was successful, but errors were found for a subset of files.
 */
+ (int) AlbumIdPartialFailure;
@end
