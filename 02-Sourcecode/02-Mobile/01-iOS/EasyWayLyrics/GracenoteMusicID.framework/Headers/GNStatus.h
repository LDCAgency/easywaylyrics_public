//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//
// 

/**
 * @file GNStatus.h
 */

#import <Foundation/Foundation.h>

/**
 * Specifies the status of an operation as it progresses.
 */
typedef enum GNStatusEnum { 
	/** The operation has not started yet. */
	IDLE, 
	/** The operation is listening audio from the microphone. */
	LISTENING, 
	/** The operation is fetching ID3 data and generating groups from audio files. */
	ANALYZING,
	/** The operation is generating a fingerprint from an audio sample. */
	FINGERPRINTING, 
	/** The operation is contacting Gracenote for identification.. */
    RECOGNIZING,
    /** The operation is facing error. */
    ERROR,
	/** The operation is being canceled. */
	CANCEL } GNStatusEnum;

/**
 * Describes the status of an operation as it progresses.
 * 
 * GNStatus is provided to the application via the GNOperationStatusChanged interface. It
 * provides a detailed description of the operation's current state and progress.
 */
@interface GNStatus : NSObject {
	@private
  GNStatusEnum m_status;
  NSString *m_message;
  int m_percentDone;
}

/**
 * Status of the operation.
 */
@property (nonatomic, assign) GNStatusEnum status;
/**
 * Message indicating status of the operation.
 */
@property (nonatomic, copy) NSString *message;
/**
 * Progress percentage of the operation. Only available for supported operations.
 */
@property (nonatomic, assign) int percentDone;

// Static instance constructor

/**
 * Obtains the enumerated status of the associated operation.
 * @return Operation status
 */

+ (GNStatus*) gNStatus:(GNStatusEnum)inStatus
               message:(NSString*)inMessage
           percentDone:(int)inPercentDone;

@end
