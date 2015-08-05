//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GNSearchResult;

/**
 * Interface that enables delivery of
 * results to an application.
 * Applications using recognition or search operations 
 * need to create an object that implements this interface and provide an instance
 * of that object when invoking the operation.
 * Mobile Client delivers the result of the operation by calling interface
 * method GNResultReady.  
 */
@protocol GNSearchResultReady

/**
 * Method called by Mobile Client to deliver the result of a recognition or
 * search operation.
 * The application can process the result in the body of this function.
 * @param result Object containing the associated operation's result
 */

- (void) GNResultReady:(GNSearchResult*)result;

@end
