//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//
// The GNOperationStatusChanged protocol defines a method
// that would be invoked when the status of an operation
// changes. The GNOperationStatusChanged protocol is
// optional, if it is not implemented by the class passed
// as the resultReady argument, then no status changes will
// be delivered.

#import <Foundation/Foundation.h>

@class GNStatus;

/**
 * Mobile Client uses this interface to provide status-changed notifications 
 * for the associated operation to the application.
 *  
 * To receive status updates, the application must create an object that implements 
 * this interface and the appropriate Result Ready interface. An instance of this 
 * object must be provided when invoking an operation.
 * 
 * As the operation progresses, it calls GNStatusChanged; the application
 * can extract and process the provided status information.
 * 
 * For more information on receiving status-changed notifications, see the
 * Mobile Client Implementation Guide.
 * 
 */
@protocol GNOperationStatusChanged

/**
 * Method invoked by Mobile Client as the associated operation progresses; the 
 * status of the operation is reported via a GNStatus object.
 * @param status The associated operation's status 
 */

- (void) GNStatusChanged:(GNStatus*)status;

@end

