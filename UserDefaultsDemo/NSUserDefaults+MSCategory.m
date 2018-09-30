//
//  NSUserDefaults+MSCategory.m
//  UserDefaultsDemo
//
//  Created by moses on 2018/9/30.
//  Copyright © 2018年 ANT. All rights reserved.
//

#import "NSUserDefaults+MSCategory.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-implementation"

@implementation NSUserDefaults (MSCategory)

static NSString * prefix = @"ms_";// 前缀

+ (void)load {
    NSArray *arr = @[@"TB,N",//bool
                     @"TC,N",//unsigned char
                     @"Tc,N",//char
                     @"TS,N",//unsigned short
                     @"Ts,N",//short
                     @"TI,N",//unsigned int
                     @"Ti,N",//int
                     @"TL,N",//unsigned long
                     @"Tl,N",//long
                     @"TQ,N",//unsigned long long
                     @"Tq,N",//long long
                     @"Tf,N",//float
                     @"Td,N",//double
                     @"T@\"NSURL\",&,N",
                     @"T@\"NSData\",&,N",
                     @"T@\"NSDate\",&,N",
                     @"T@\"NSString\",&,N",
                     @"T@\"NSNumber\",&,N",
                     @"T@\"NSArray\",&,N",
                     @"T@\"NSDictionary\",&,N"];
    u_int count;
    // 属性列表
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        // get方法名
        NSString *getSel = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSString *first = [getSel substringToIndex:1];
        NSAssert([first isEqualToString:first.lowercaseString], @"属性名首字母不能大写");
        // 将首字母大写
        NSString *uppercase = [NSString stringWithFormat:@"%@%@", [[getSel substringToIndex:1] uppercaseString], [getSel substringFromIndex:1]];
        // set方法名
        NSString *setSel = [NSString stringWithFormat:@"set%@:", uppercase];
        // 属性类型
        NSString *attribute = [NSString stringWithUTF8String:property_getAttributes(properties[i])];
        // 检查NSUserDefaults是否可以存储这个类型
        NSAssert([arr containsObject:attribute], @"属性列表中存在不能存储的类型");
        
        NSString *code = [attribute substringWithRange:NSMakeRange(1, 1)];
        const char * save_types = [[NSString stringWithFormat:@"V@:%@", code] UTF8String];
        const char * read_types = [[NSString stringWithFormat:@"%@@:", code] UTF8String];
        IMP save_IMP,read_IMP;
        if ([attribute isEqualToString:@"T@\"NSURL\",&,N"]) {
            save_IMP = (IMP)ms_saveURL;
            read_IMP = (IMP)ms_readURL;
        } else if ([code isEqualToString:@"@"]) {
            save_IMP = (IMP)ms_saveObjC;
            read_IMP = (IMP)ms_readObjC;
        } else if ([code isEqualToString:@"d"]) {
            save_IMP = (IMP)ms_saveDouble;
            read_IMP = (IMP)ms_readDouble;
        } else if ([code isEqualToString:@"f"]) {
            save_IMP = (IMP)ms_saveFloat;
            read_IMP = (IMP)ms_readFloat;
        } else if ([code isEqualToString:@"q"] || [code isEqualToString:@"l"]) {
            save_IMP = (IMP)ms_saveLong;
            read_IMP = (IMP)ms_readLong;
        } else if ([code isEqualToString:@"Q"] || [code isEqualToString:@"L"]) {
            save_IMP = (IMP)ms_saveUnsignedLong;
            read_IMP = (IMP)ms_readUnsignedLong;
        } else if ([code isEqualToString:@"I"]) {
            save_IMP = (IMP)ms_saveUnsignedInt;
            read_IMP = (IMP)ms_readUnsignedInt;
        } else {
            save_IMP = (IMP)ms_saveInt;
            read_IMP = (IMP)ms_readInt;
        }
        bool save = class_addMethod([self class], NSSelectorFromString(setSel), save_IMP, save_types);
        bool read = class_addMethod([self class], NSSelectorFromString(getSel), read_IMP, read_types);
        NSAssert(save&&read, @"添加方法失败");
    }
    free(properties);
}

#pragma mark - NSURL
static void ms_saveURL(id self, SEL _cmd, NSURL *obj) {
    [[NSUserDefaults standardUserDefaults] setURL:obj forKey:GetKeyWithSelector(_cmd)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
static NSURL * ms_readURL(id self, SEL _cmd) {
    NSString *key = [NSString stringWithFormat:@"%@%@", prefix, NSStringFromSelector(_cmd)];
    return [[NSUserDefaults standardUserDefaults] URLForKey:key];
}

#pragma mark - 其他OC类型
static void ms_saveObjC(id self, SEL _cmd, id obj) {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:GetKeyWithSelector(_cmd)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
static id ms_readObjC(id self, SEL _cmd) {
    NSString *key = [NSString stringWithFormat:@"%@%@", prefix, NSStringFromSelector(_cmd)];
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark - bool,char,short,int
static void ms_saveInt(id self, SEL _cmd, int value) {
    [[NSUserDefaults standardUserDefaults] setObject:@(value) forKey:GetKeyWithSelector(_cmd)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
static int ms_readInt(id self, SEL _cmd) {
    NSString *key = [NSString stringWithFormat:@"%@%@", prefix, NSStringFromSelector(_cmd)];
    return [[[NSUserDefaults standardUserDefaults] objectForKey:key] intValue];
}

#pragma mark - unsigned int
static void ms_saveUnsignedInt(id self, SEL _cmd, unsigned int value) {
    [[NSUserDefaults standardUserDefaults] setObject:@(value) forKey:GetKeyWithSelector(_cmd)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
static unsigned int ms_readUnsignedInt(id self, SEL _cmd) {
    NSString *key = [NSString stringWithFormat:@"%@%@", prefix, NSStringFromSelector(_cmd)];
    return [[[NSUserDefaults standardUserDefaults] objectForKey:key] unsignedIntValue];
}

#pragma mark - long
static void ms_saveLong(id self, SEL _cmd, long value) {
    [[NSUserDefaults standardUserDefaults] setObject:@(value) forKey:GetKeyWithSelector(_cmd)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
static long ms_readLong(id self, SEL _cmd) {
    NSString *key = [NSString stringWithFormat:@"%@%@", prefix, NSStringFromSelector(_cmd)];
    return [[[NSUserDefaults standardUserDefaults] objectForKey:key] longValue];
}

#pragma mark - unsigned long
static void ms_saveUnsignedLong(id self, SEL _cmd, unsigned long value) {
    [[NSUserDefaults standardUserDefaults] setObject:@(value) forKey:GetKeyWithSelector(_cmd)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
static unsigned long ms_readUnsignedLong(id self, SEL _cmd) {
    NSString *key = [NSString stringWithFormat:@"%@%@", prefix, NSStringFromSelector(_cmd)];
    return [[[NSUserDefaults standardUserDefaults] objectForKey:key] unsignedLongValue];
}

#pragma mark - float
static void ms_saveFloat(id self, SEL _cmd, float value) {
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:GetKeyWithSelector(_cmd)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
static float ms_readFloat(id self, SEL _cmd) {
    NSString *key = [NSString stringWithFormat:@"%@%@", prefix, NSStringFromSelector(_cmd)];
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

#pragma mark - double
static void ms_saveDouble(id self, SEL _cmd, double value) {
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:GetKeyWithSelector(_cmd)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
static double ms_readDouble(id self, SEL _cmd) {
    NSString *key = [NSString stringWithFormat:@"%@%@", prefix, NSStringFromSelector(_cmd)];
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

#pragma mark - 通过set方法名获取键名
static NSString * GetKeyWithSelector(SEL sel) {
    NSString *name = [NSStringFromSelector(sel) substringWithRange:NSMakeRange(3, NSStringFromSelector(sel).length - 4)];
    name = [NSString stringWithFormat:@"%@%@", [[name substringToIndex:1] lowercaseString], [name substringFromIndex:1]];
    return [NSString stringWithFormat:@"%@%@", prefix, name];
}

@end
#pragma clang diagnostic pop
