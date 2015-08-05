//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GNOperationQueue;
@class GNFingerprinterQueue;
@class GNLocalLookUp;
@class GNCacheStatus;

/**
 * The GNConfig module implements a configuration object that is required when invoking a
 * GNOperations module operation. You call GNConfig init, passing it a Gracenote-provided Client Id
 * String, to create a GNConfig object.
 *
 * <p>Typically, applications use the default configuration object.
 * To change application-wide configuration properties, call the
 * GNConfig setProperty method.</p>
 *
 * <p>To create custom configuration options for a single
 * GNOperations invocation, create a GNConfig object copy (using the
 * copy method), set copy properties, and pass the copy to the
 * GNOperations method.</p>
 *
 * <p>Supported Properties:</p>
 *
 * <table border="1" cellspacing=2 cellpadding=5>
 * <tr><th>Property</th> <th>Type</th> <th>Access</th> <th>Default</td> <th>Description</th></tr>
 *
 * <tr><td>clientId</td>
 *     <td><pre>String</pre></td>
 *     <td>Read only</td>
 *     <td><pre>""</pre></td>
 *     <td>Client Id supplied when GNConfig init is called during object creation.</td>
 * </tr>
 *
 * <tr><td>content.albumId.queryPreference.useFingerprint</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"1"</pre></td>
 *     <td>If "1", AlbumId query uses fingerprints.</td>
 * </tr>
 *
 * <tr><td>content.albumId.queryPreference.useGN_ID</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"1"</pre></td>
 *     <td>If "1", AlbumId query uses GN_ID.</td>
 * </tr>
 *
 * <tr><td>content.albumId.queryPreference.useTagData</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"1"</pre></td>
 *     <td>If "1", AlbumId query uses ID3 tag data for lookup.</td>
 * </tr>
 *
 * <tr><td>content.artistType</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", the artist type (if available) is returned. </td>
 * </tr>
 *
 * <tr><td>content.artistType.level</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"DEFAULT"</pre></td>
 *     <td>If "DEFAULT" (or anything other than "EXTENDED"), a single, default artist type descriptor is returned. If "EXTENDED", multiple levels of artist type descriptors are returned.</td>
 * </tr>
 *
 * <tr><td>content.contributor.biography</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", a contributor biography (if available) is returned. Only applicable to products that return a single best match.</td>
 * </tr>
 *
 * <tr><td>content.contributor.images</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", a contributor image (if available) is returned.
 *     Only applicable to products that return a single best match.</td>
 * </tr>
 *
 * <tr><td>content.country</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"usa"</pre></td>
 *     <td>Metadata (if available) for the specified country is returned. All ISO 3166-1 alpha-3 country codes are supported.</td>
 * </tr>
 *
 * <tr><td>content.coverArt</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", cover art (if available) is returned.
 *     Only applicable to products that return a single best match.</td>
 * </tr>
 *
 * <tr><td>content.coverArt.genreCoverArt</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"1"</pre></td>
 *     <td>If "1", genre cover art (if available) is returned.
 *     Only applicable to products that return a single best match.</td>
 * </tr>
 *
 * <tr><td>content.coverArt.sizePreference</td>
 *     <td><pre>Comma Separated String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"SMALL,MEDIUM,THUMBNAIL,LARGE,XLARGE"</pre></td>
 *     <td><p>Cover art can be returned in various sizes depending on availability and application preferences (e.g., this parameter).
 *     </p>
 *     <p>List the cover art sizes in a comma-separated list, in preference order.</p>
 *     <p>If an invalid size preference is provided, the default is used.</p></td>
 * </tr>
 *
 *  <tr><td>content.era</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", era metadata (if available) is returned.</td>
 * </tr>
 *
 * <tr><td>content.era.level</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"DEFAULT"</pre></td>
 *     <td>If "DEFAULT", a single, default era descriptor is returned. If "EXTENDED", multiple levels of era descriptors are returned.</td>
 * </tr>
 *
 * <tr><td>content.genre.level</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"DEFAULT"</pre></td>
 *     <td>If "DEFAULT", a single, default genre descriptor is returned. If "EXTENDED", multiple levels of genre descriptors are returned.</td>
 * </tr>
 *
 * <tr><td>content.allowFullResponse</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", a full response, when there is a single best match, is returned .</td>
 * </tr>
 *
 * <tr><td>content.lang</td>
 * 	   <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>""</pre> (no specific language)</td>
 *     <td>Preferred language for results. Check with Gracenote for the full set of supported ISO 639-2 languages and codes. Example language values are
 *            "eng" (English), "kor" (Korean), "ger" (German), "spa" (Spanish), and "jpn" (Japanese).
 *     </td>
 * </tr>
 *
 * <tr><td>content.link.preferredSource</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>""</pre> (no specific preferred link)</td>
 *     <td>Indicates the preferred Link identifier source when performing an audio recognition
 *     request that returns a single best match. Does not apply to AlbumId.</td>
 * </tr>
 *
 * <tr><td>content.mood</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", mood (if available) is returned.</td>
 * </tr>
 *
 * <tr><td>content.mood.level</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"DEFAULT"</pre></td>
 *     <td>If "DEFAULT", a single, default mood descriptor is returned. If "EXTENDED", additional mood descriptor levels are returned.</td>
 * </tr>
 *
 * <tr><td>content.musicId.queryPreference.singleBestMatch</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"1"</pre></td>
 *     <td>If "1", a single best match is returned. Otherwise, multiple matches could be returned.
 *		Only applicable to MIDF and MID stream operations.</td>
 * </tr>
 *
 *  <tr><td>content.origin</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", origin (if available) is returned.</td>
 * </tr>
 *
 * <tr><td>content.origin.level</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"DEFAULT"</pre></td>
 *     <td>If "DEFAULT", a single, default origin descriptor is returned. If "EXTENDED", multiple levels of origin descriptors are returned.</td>
 * </tr>
 *
 * <tr><td>content.review</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", an album content review (if available) is returned. Only applicable to products that return a single best match.</td>
 * </tr>
 *
 * <tr><td>content.tempo</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", tempo (if available) is returned.</td>
 * </tr>
 *
 * <tr><td>content.tempo.level</td>
 *     <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"DEFAULT"</pre></td>
 *     <td>If "DEFAULT", a single, default tempo descriptor is returned. If "EXTENDED", multiple levels of tempo descriptors are returned.</td>
 * </tr>
 *
 * <tr><td>debugEnabled</td>
 *     <td><pre>Boolean String</pre></td>
 *     <td>Read/Write</td>
 *     <td><pre>"0"</pre></td>
 *     <td>If "1", debug information is written to the file specified in the <code>debugLog</code> property.</td>
 * </tr>
 *
 * <tr><td>debugLog</td>
 * 	   <td><pre>String</pre></td>
 *     <td>Read/Write</td>
 *     <td>The application document root directory.</td>
 *     <td>Path of the debug log file that is created when <code>debugEnabled</code> is "1".</td>
 * </tr>
 *
 * <tr><td>version</td>
 *     <td><pre>String</pre></td>
 *     <td>Read only</td>
 *     <td>Mobile Client Version</td>
 *     <td>Release version information.</td>
 * </tr>
 *
 * </table>
 */

@interface GNConfig : NSObject <NSCopying> {
@private
  NSMutableDictionary *m_publicProperties;
  NSMutableDictionary *m_protectedProperties;
  GNOperationQueue *m_opQueue;
  GNFingerprinterQueue *m_fpQueue;
  NSMutableDictionary *m_deprecatedProperty;
  NSMutableDictionary *m_defaultBooleanValue;
    GNLocalLookUp *m_localLookUp;
}


// Static construction, returns instance of the default config object.
// If this init method is invoked twice, the same default config object
// is returned as the result of the second invocation. It is an error if
// the the clientId passed to this method does not match the clientId
// passed to an earlier invocation. Note the caller of this method
// should not release the config reference returned by this method,
// use the cleanup method to release the default config reference.

/**
 * Creates a configuration object that is used when invoking a Mobile Client operation
 * via the GNOperations module.
 *
 * Configuration objects must be created prior to invoking any Mobile Client operations.
 * Invoke this method to create a configuration object. Be sure to store the returned object.
 *
 * You must use a Gracenote-provided Client Id to create a configuration object.
 *
 * @return Configuration object instance initialized with the default property values.
 */

+ (GNConfig*) init:(NSString*)inClientId;

/**
 * Set up cache from bundle file path. To get bundle contact Gracenote Professional service.
 *
 * @param bundleFilePath Bundle File path as a String.
 */

-(GNCacheStatus*) loadCache:(NSString*)bundleFilePath;

/**
 * Removes previously loaded cache, if exists. Ignore otherwise.
 */

-(GNCacheStatus*) clearCache;

/**
 * Removes previously loaded cache, if exists and compresses the database.
 * @param compactDatabase  compactDatabase as a BOOL specifying whether to compact
 * the SQLlite Database or not.
 */

-(GNCacheStatus*) clearCache:(BOOL) compactDatabase;


// Sets a public property identified by a string key.

/**
 * Sets the value of a configuration object property.
 *
 * @param key  Property name
 * @param value  Property value as a String. For properties of type "Boolean String", the value can be
 * "1", "true" or "True", or "0", "false" or "False".
 */

- (void) setProperty:(NSString*)key value:(NSString*)value;

// Gets a public property identified by a string key.
/**
 * Returns the value for a configuration object property.
 *
 * @param key  Property name
 * @return String Property value
 */

- (NSString*) getProperty:(NSString*)key;

// Gets a public property identified by a string key as a boolean.

/**
 * Simplifies testing of configuration object properties whose type is "Boolean String".
 *
 * This method can be used to read configuration object properties of type "Boolean String".
 * When used to obtain a property value of any other type, an exception is thrown.
 *
 * @param key  Property name
 * @return Value of the property, true for "1", "true" or "True"; false for "0", "false" or "False".
 */

- (BOOL) getBooleanProperty:(NSString*)key;


@end
