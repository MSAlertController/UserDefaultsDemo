//
//  NSUserDefaults+MSCategory.h
//  UserDefaultsDemo
//
//  Created by moses on 2018/9/30.
//  Copyright © 2018年 ANT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (MSCategory)

// OC类型示例(这几个OC类型是plist文件支持的)
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSDictionary *dic;

// 基本类型示例
@property (nonatomic, assign) bool msbool;
@property (nonatomic, assign) BOOL msBOOL;
@property (nonatomic, assign) Boolean msBoolean;
@property (nonatomic, assign) boolean_t msboolean_t;
@property (nonatomic, assign) char mschar;
@property (nonatomic, assign) unsigned char ms_char;
@property (nonatomic, assign) short msshort;
@property (nonatomic, assign) unsigned short ms_short;
@property (nonatomic, assign) int msint;
@property (nonatomic, assign) unsigned int ms_int;
@property (nonatomic, assign) long mslong;
@property (nonatomic, assign) unsigned long ms_long;
@property (nonatomic, assign) long long mslonglong;
@property (nonatomic, assign) unsigned long long ms_longlong;
@property (nonatomic, assign) NSInteger msinteger;
@property (nonatomic, assign) NSUInteger ms_integer;
@property (nonatomic, assign) float msfloat;
@property (nonatomic, assign) double msdouble;

@end
