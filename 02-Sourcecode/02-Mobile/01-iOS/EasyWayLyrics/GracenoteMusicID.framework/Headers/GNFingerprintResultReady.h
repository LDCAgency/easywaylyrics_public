//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GNFingerprintResult;

/**
 * Interface provided by Mobile Client to enable delivery of results to an application.
 * 
 * Applications using Mobile Client's fingerprint generation operations 
 * need to create an object that implements this interface and provide an instance
 * of that object when invoking the operation.
 * Mobile Client delivers the result of the operation by calling the interface
 * method GNResultReady.  
 */
@protocol GNFingerprintResultReady

/**
 * Method called by Mobile Client to deliver the result of a fingerprint
 * generation operation.
 * The application can process the result in the body of this function.
 * @param result object containing the result of the associated operation
 */
- (void) GNResultReady:(GNFingerprintResult*)result;

@end
