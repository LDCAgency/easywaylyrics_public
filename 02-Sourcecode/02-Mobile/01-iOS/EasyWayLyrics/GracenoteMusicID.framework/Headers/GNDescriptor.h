//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2011. All rights reserved.
//

/**
 * Container class for Genre, Mood, and Tempo returned by a match 
 * generated from a recognition or search operation.
 *
 */

#import <Foundation/Foundation.h>


@interface GNDescriptor : NSObject {
   @private
    NSString *m_Ord;
    NSString *m_Id;
    NSString *m_Data;
}
/**
 * The ordinal of the Genre/Mood/Tempo identified in the response.
 */
@property(nonatomic,retain)NSString *itemOrd;
/**
 * The ID of the Genre/Mood/Tempo identified in the response.
 */
@property(nonatomic,retain)NSString *itemId;
/**
 * The value of the Genre/Mood/Tempo identified in the response.
 */
@property(nonatomic,retain)NSString *itemData;
/**
 * The integer value of the itemOrd.
 */
@property(nonatomic, readonly)NSInteger ordIntValue;

// Static instance constructor
/**
 * Contains the GNDescriptor returned by an operation.
 */

+(GNDescriptor *) gNDescriptor:(NSString *)Ord itemId:(NSString *)Id itemData:(NSString *)data;

@end
