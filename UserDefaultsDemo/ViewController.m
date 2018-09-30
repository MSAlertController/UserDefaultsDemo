//
//  ViewController.m
//  UserDefaultsDemo
//
//  Created by moses on 2018/9/30.
//  Copyright © 2018年 ANT. All rights reserved.
//

#import "ViewController.h"
#import "NSUserDefaults+MSCategory.h"
#define UserDefault [NSUserDefaults standardUserDefaults]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserDefault.url = [NSURL URLWithString:@"https://www.baidu.com/"];
    UserDefault.data = UIImagePNGRepresentation([UIImage imageNamed:@"apple"]);
    UserDefault.date = [NSDate dateWithTimeIntervalSince1970:1538300000];
    UserDefault.str = @"Objective-C";
    UserDefault.num = @(2543876432);
    UserDefault.arr = @[@"AFNetworking", @"SDWebImage", @"MJRefresh", @"MJExtension"];
    UserDefault.dic = @{@"name" : @"moses", @"age" : @(18)};
    
    NSLog(@"%@", UserDefault.url);
    NSLog(@"%@", UserDefault.data);
    NSLog(@"%@", UserDefault.date);
    NSLog(@"%@", UserDefault.str);
    NSLog(@"%@", UserDefault.num);
    NSLog(@"%@", UserDefault.arr);
    NSLog(@"%@", UserDefault.dic);
    
    // 以下基本类型均以64位设备为例
    UserDefault.msbool = 2345654654654;//非0即真
    UserDefault.msBOOL = 2345645654654;//非0即真
    UserDefault.msBoolean = 255;//0 ~ 255
    UserDefault.msboolean_t = -2147483648;//-2147483648 ~ 2147483647
    UserDefault.mschar = -128;//-128 ~ 127
    UserDefault.ms_char = 255;//0 ~ 255
    UserDefault.msshort = -32768;//-32768 ~ 32767
    UserDefault.ms_short = 65535;//0 ~ 65535
    UserDefault.msint = -2147483648;//-2147483648 ~ 2147483647
    
    UserDefault.ms_int = 4294967295;//这个比较特殊,不建议使用unsigned int
    //存储范围没有问题是0 ~ 4294967295,但是由于unsignedIntValue方法有问题,导致最后读取范围是-2147483648 ~ 2147483647
    
    UserDefault.mslong = -1538300000000;
    UserDefault.ms_long = 1538300000000;
    UserDefault.mslonglong = -1538300000000;
    UserDefault.ms_longlong = 1538300000000;
    UserDefault.msinteger = -1538300000000;
    UserDefault.ms_integer = 1538300000000;
    UserDefault.msfloat = 2.345678;//精度为6位
    UserDefault.msdouble = 2.34567891011;//精度为15位
    
    NSLog(@"%d", UserDefault.msbool);
    NSLog(@"%d", UserDefault.msBOOL);
    NSLog(@"%d", UserDefault.msBoolean);
    NSLog(@"%d", UserDefault.msboolean_t);
    NSLog(@"%d", UserDefault.mschar);
    NSLog(@"%d", UserDefault.ms_char);
    NSLog(@"%d", UserDefault.msshort);
    NSLog(@"%d", UserDefault.ms_short);
    NSLog(@"%d", UserDefault.msint);
    NSLog(@"%d", UserDefault.ms_int);
    NSLog(@"%ld", UserDefault.mslong);
    NSLog(@"%ld", UserDefault.ms_long);
    NSLog(@"%lld", UserDefault.mslonglong);
    NSLog(@"%lld", UserDefault.ms_longlong);
    NSLog(@"%ld", UserDefault.msinteger);
    NSLog(@"%ld", UserDefault.ms_integer);
    NSLog(@"%f", UserDefault.msfloat);
    NSLog(@"%.11f", UserDefault.msdouble);
    
}
/*
2018-09-30 20:00:00.084595+0800 UserDefaultsDemo[97510:12926575] https://www.baidu.com/
2018-09-30 20:00:00.093073+0800 UserDefaultsDemo[97510:12926575] <89504e47 …………
2018-09-30 20:00:00.139430+0800 UserDefaultsDemo[97510:12926575] Sun Sep 30 17:33:20 2018
2018-09-30 20:00:00.139695+0800 UserDefaultsDemo[97510:12926575] Objective-C
2018-09-30 20:00:00.140027+0800 UserDefaultsDemo[97510:12926575] 2543876432
2018-09-30 20:00:00.166833+0800 UserDefaultsDemo[97510:12926575] 1
2018-09-30 20:00:00.167477+0800 UserDefaultsDemo[97510:12926575] 1
2018-09-30 20:00:00.167946+0800 UserDefaultsDemo[97510:12926575] 255
2018-09-30 20:00:00.168387+0800 UserDefaultsDemo[97510:12926575] -2147483648
2018-09-30 20:00:00.169005+0800 UserDefaultsDemo[97510:12926575] -128
2018-09-30 20:00:00.169594+0800 UserDefaultsDemo[97510:12926575] 255
2018-09-30 20:00:00.170139+0800 UserDefaultsDemo[97510:12926575] -32768
2018-09-30 20:00:00.170612+0800 UserDefaultsDemo[97510:12926575] 65535
2018-09-30 20:00:00.171172+0800 UserDefaultsDemo[97510:12926575] -2147483648
2018-09-30 20:00:00.171709+0800 UserDefaultsDemo[97510:12926575] -1
2018-09-30 20:00:00.172196+0800 UserDefaultsDemo[97510:12926575] -1538300000000
2018-09-30 20:00:00.172847+0800 UserDefaultsDemo[97510:12926575] 1538300000000
2018-09-30 20:00:00.173421+0800 UserDefaultsDemo[97510:12926575] -1538300000000
2018-09-30 20:00:00.174107+0800 UserDefaultsDemo[97510:12926575] 1538300000000
2018-09-30 20:00:00.174751+0800 UserDefaultsDemo[97510:12926575] -1538300000000
2018-09-30 20:00:00.175195+0800 UserDefaultsDemo[97510:12926575] 1538300000000
2018-09-30 20:00:00.175750+0800 UserDefaultsDemo[97510:12926575] 2.345678
2018-09-30 20:00:00.176294+0800 UserDefaultsDemo[97510:12926575] 2.34567891011
 */

@end
