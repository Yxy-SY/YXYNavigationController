//
//  NSStringExtend.h
//  Etion
//
//  Created by  user on 11-7-30.
//  Copyright 2011 GuangZhouXuanWu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreGraphics/CGGeometry.h>

#import <UIKit/UIFont.h>

//#import "XMSGUID.h"

#define GBK2312Encoding CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)

@class XMSQueueDictionary;

@interface NSString (NSStringExtend)

+ (NSString *)replaceString:(NSString *)str replacekv:(NSDictionary *)kv;

- (NSString*)replaceStringWithKv:(NSDictionary *)kv;

//- (NSString *)transformToFirstLetter:(NSString *)szStr;

+ (BOOL)isImageExtension:(NSString *)szFilename;

//- (NSString *)findLetter:(int)nCode;

//- (NSMutableArray *)getPinYinFromChiniseString:(NSString *)string;

//+ (NSMutableArray *)getPinYinFromChiniseString:(NSString *)string abortUnCNString:(BOOL)bAbort;

//+ (NSMutableDictionary *)sortByPinYin:(NSMutableArray *)arEntcontact name:(NSString *(^)(id obj))obj pinYinName:(void (^)(int nIndex, NSMutableArray *arPinyinname))pinyinname comparePinYinName:(NSMutableArray *(^)(id obj))compare;

//+ (NSArray *)sortByPinYin:(NSArray *)arEntcontact comparePinYinName:(NSArray *(^)(id obj))compare;

- (NSString*)transformToPinYin;

//对字符串数组按某一间隔符进行拼接
+ (NSString *)megerStringWithTag:(NSArray *)arStr tag:(NSString *)szTag;

//对数组对象中某一属性按某一间隔符进行拼接
+ (NSString *)megerStringWithTag:(NSArray *)arStr property:(NSString *)szProperty tag:(NSString *)szTag;

//对数组中某一属性值按某一间隔符进行拼接
+ (NSString *)megerStringWithTag:(NSArray *)arStr value:(NSString *(^)(id obj))value tag:(NSString *)szTag;

//对返回的字符串某一间隔符进行拼接
+ (NSString *)megerStringWithString:(NSString*(^)(NSUInteger nIndex, BOOL *bStop))string tag:(NSString *)szTag;

//去掉字符串中的空格和换行符
+ (NSString *)deleteSpacesAndLineBreaksWith:(NSString*)arStr;

+ (XMSQueueDictionary *)splitKeyValueString:(NSString*)str withTag:(NSString*)tag;

- (XMSQueueDictionary *)splitKeyValueStringWithTag:(NSString*)tag;

+ (XMSQueueDictionary *)splitString:(NSString*)str withStringTag:(NSString*)tag1 andKeyValueStringTag:(NSString*)tag2;

- (XMSQueueDictionary *)splitWithStringTag:(NSString*)tag1 andKeyValueStringTag:(NSString*)tag2;



+ (CGSize)charSizeWithFont:(UIFont*)font;

+ (CGSize)charSizeWithSystemFontSize:(CGFloat)fontSize;

- (CGSize)stringSizeWithFont:(UIFont*)font;

- (CGSize)stringSizeWithSystemFontSize:(CGFloat)fontSize;

- (CGSize)stringSizeWithFont:(UIFont*)font forWidth:(CGFloat)width;

- (CGSize)stringSizeWithSystemFontSize:(CGFloat)fontSize forWidth:(CGFloat)width;

- (CGSize)stringSizeWithFont:(UIFont*)font forConstrainSize:(CGSize)constrainSize;

- (CGSize)stringSizeWithSystemFontSize:(CGFloat)fontSize forConstrainSize:(CGSize)constrainSize;

- (CGSize)wrapStringSizeWithFont:(UIFont*)font forWidth:(CGFloat)width;

- (CGSize)wrapStringSizeWithSystemFontSize:(CGFloat)fontSize forWidth:(CGFloat)width;

- (CGSize)wrapStringSizeWithFont:(UIFont*)font forConstrainSize:(CGSize)constrainSize;

- (CGSize)wrapStringSizeWithSystemFontSize:(CGFloat)fontSize forConstrainSize:(CGSize)constrainSize;

- (NSRange)truncatesStringOfLines:(NSUInteger)lines forContainWidth:(CGFloat)containWidth font:(UIFont*)font;


+ (BOOL)isNumberString:(NSString *)str;

- (BOOL)isNumberString;

+ (BOOL)isFloatNumberString:(NSString *)str;

- (BOOL)isFloatNumberString;

+ (BOOL)isBlankString:(NSString *)str;

- (BOOL)isBlankString;

+ (BOOL)isEmailString:(NSString *)str;

- (BOOL)isEmailString;

+ (BOOL)isEnglishString:(NSString *)str;

- (BOOL)isEnglishString;

+ (BOOL)isHttpString:(NSString *)str;

- (BOOL)isHttpString;

+ (BOOL)isMobileNumber:(NSString *)str;

- (BOOL)isMobileNumber;

+ (BOOL)isTelephoneNumber:(NSString *)str;

- (BOOL)isTelephoneNumber;

//+ (BOOL)isFaxNumber:(NSString *)str;
//
//- (BOOL)isFaxNumber;

+ (NSString*)stringValue:(NSString*)string;

+ (NSUInteger)hexToUInt:(NSString *)szHex;

- (NSUInteger)hexToUInt;

- (NSDate *)toNSDate:(NSString *)szFormat;

- (NSString *)md5_32;

- (NSString *)base64;

@end

@interface NSString (GUID)

//- (GUID)GUIDValue;

@end
