//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//
//

/**
 * @file GNCacheStatus.h
 */


#import <Foundation/Foundation.h>

/**
 *  Specifies result of a call to clear or load cache
 *
 */

typedef enum GNCacheStatusEnum {
	
    SUCCESS, 				/* operation succeeded */
    BUSY,   				/* operation aborted, unable to access cache */
    FILE_NOT_FOUND, 		/* invalid bundle file path */
    OPEN_DATABASE_FAILED,	/* failed to open database */
    MEM_LOAD_FAILED,		/* database has been updated from a call to loadCache but failed to load fingerprint data into memory */
    INVALID_BUNDLE,			/* failed to parse bundle, bundle format is invalid */
    DB_UPDATE_FAILED,   	/* failed to update database with bundle contents */
    CACHEERROR,				/* unknown error, check debug log */
    DB_VACUUM_FAILED       /*  vacuum operation failed */
	
}GNCacheStatusEnum;



@interface GNCacheStatus : NSObject{
    
GNCacheStatusEnum m_cacheStatus;
    
}

/**
 * Status of the operation.
 */
@property (nonatomic, assign) GNCacheStatusEnum cacheStatus;

/**
 * Obtains the enumerated status of the associated operation.
 * @return Operation status
 */
+ (GNCacheStatus*) gNCacheStatus:(GNCacheStatusEnum)inStatus;

/**
 * Returns the enumarated status as a string.
 * @return Status string
 */
- (NSString*) statusString;

@end
