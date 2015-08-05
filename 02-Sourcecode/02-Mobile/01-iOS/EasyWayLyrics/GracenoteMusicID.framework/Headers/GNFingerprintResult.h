//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

/**
 * Contains the result of a fingerprint operation. This class extends
 * GNResult with result fields that are specific to a fingerprint
 * generation operation.
 */

#import <Foundation/Foundation.h>
#import "GNResult.h"

@interface GNFingerprintResult : GNResult {
  @private
	NSString *m_fingerprintData;
}

@property (nonatomic, copy) NSString *fingerprintData;

+ (GNFingerprintResult*) gNFingerprintResult:(GNConfig*)config;

/** 
 * Returns the fingerprint as a String.
 * @return Fingerprint as a String
 */

+ (GNFingerprintResult*) gNFingerprintResultWithResult:(GNResult*)result;

/**
 * Saves the fingerprint to the specified file.
 * @param filename Name and path of the file
 */

- (void) saveFingerprintAs:(NSString*)filename;

@end
