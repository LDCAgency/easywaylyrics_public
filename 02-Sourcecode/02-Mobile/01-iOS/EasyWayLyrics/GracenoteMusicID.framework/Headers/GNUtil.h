//
//  iOSMobileSDK
//  Copyright Gracenote Inc. 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Contains various Mobile Client utility methods.
 */
@interface GNUtil : NSObject {
}

/**
 * Reads a UTF-8 encoded text file into a string.
 * 
 * Reads a UTF-8 encoded file into a string one page (4096 bytes) at a time. When the
 * entire file is read, returns a string that contains the file contents.
 * This method is useful for reading plain text files and XML files. 
 * 
 * @param filename UTF-8 encoded file to read
 * @return String containing the file data. When the file does not exist, or there was
 * a problem reading the file, returns null.
 */

+ (NSString*) readUTF8:(NSString*)filename;

/**
 * Writes a string to a UTF-8 encoded text file.
 * 
 * Converts the provided string to UTF-8 and writes it to a UTF-8 encoded text file.
 * Creates the file if it does not exist; overwrites the file when it does exist.
 * 
 * @param filename UTF-8 encoded file to write the string to
 * @param string Data string to append to the UTF-8 encoded file
 * @return True when the data string is correctly appended, false when there is an error writing
 * to the file.
 */

+ (BOOL) writeUTF8:(NSString*)filename string:(NSString*)string;

/**
 * Appends a string to a UTF-8 encoded text file.
 * 
 * Converts the provided string to UTF-8 and appends it to a UTF-8 encoded text file.
 * Creates the file if it does not exist.
 * 
 * @param filename UTF-8 encoded file to append the string to
 * @param string Data string to append to the UTF-8 encoded file
 * @return True when the data string is correctly appended to the file, false when there is 
 * an error writing to the file.
 */

+ (BOOL) appendUTF8:(NSString*)filename string:(NSString*)string;

@end
