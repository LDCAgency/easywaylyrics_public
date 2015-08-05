//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//


/**
 * Container Class for Image of artist and coverArt 
 * 
 * */

#import <Foundation/Foundation.h>

@interface GNImage : NSObject {

@private
    NSString * m_size;
    NSData *m_data;
    NSString *m_mimeType;
    NSString *m_url;
}

/**
 * Size of the image data in bytes. 
 */
@property (nonatomic, copy) NSString *size;
/**
 * Image data. 
 */
@property (nonatomic, copy) NSData *data;
/**
 * MIME type of the image data. 
 */
@property (nonatomic, copy) NSString *mimeType;

/**
 * Image url. 
 */
@property (nonatomic, copy) NSString *url;

// Static instance constructor

/** 
 * Returns the GNImage object.
 * @return the GNImage instance
 */

-(GNImage*)initWithSize:(NSString*)inSize
             data:(NSData*)inData
         mimeType:(NSString*)inMimeType;

-(GNImage*)initWithUrl:(NSString*)inUrl 
            size:(NSString*)inSize;

@end
