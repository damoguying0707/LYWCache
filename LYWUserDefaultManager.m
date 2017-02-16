
//  Created by vincent.li  on 7/2/15.
//  Copyright (c) 2015 LYWIN. All rights reserved.
//

#import "LYWUserDefaultManager.h"
#import "LYWUserKeyChainManager.h"
#import "Signature.h"

NSString * const kDataStoreUID          = @"kcid";
NSString * const kDataStoreTempUID      = @"temp_kcid";
NSString * const kDataStorePassword     = @"kcpsw";
NSString * const kDataStorePhone        = @"phone";
NSString * const kDataStoreAC           = @"ac";
NSString * const kDataStoreTempAC       = @"temp_ac";

@implementation LYWUserDefaultManager

- (id)init {
    
    self = [super init];
    if (self)  {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark - common fun

+ (NSString *)getLocalDataString:(NSString *)aKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (nil == defaults || nil == aKey) {
        return nil;
    }
    
    NSString *strRet = [defaults objectForKey:aKey];
    
    return strRet;
}

+ (void)setLocalDataString:(NSString *)aValue key:(NSString *)aKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (nil == defaults || nil == aKey) {
        return;
    }
    
    [defaults setValue:aValue forKey:aKey];
    [defaults synchronize];
}

+ (BOOL)getLocalDataBoolen:(NSString *)aKey {
    BOOL bRet = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (nil == defaults || nil == aKey) {
        bRet = NO;
    } else {
        bRet = [defaults boolForKey:aKey];
    }
    
    return bRet;
}

+ (void)setLocalDataBoolen:(BOOL)bValue key:(NSString *)aKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (nil == defaults || nil == aKey) {
        return;
    }
    
    [defaults setBool:bValue forKey:aKey];
    [defaults synchronize];
}

+ (NSInteger)getLocalDataInt:(NSString *)aKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (nil == defaults || aKey == nil) {
        return 0;
        
    } else {
        return [defaults integerForKey:aKey];
    }
}

+ (CGFloat)getLocalDataCGfloat:(NSString *)aKey {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (nil == defaults || aKey == nil) {
        return 0;

    } else {
        return [defaults floatForKey:aKey];
    }
}

+ (void)setLocalDataCGfloat:(CGFloat)num key:(NSString *)aKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (nil == defaults || aKey == nil) {
        return ;
    }
    [defaults setFloat:num forKey:aKey];
    [defaults synchronize];
    
}

+ (void)setLocalDataInt:(NSInteger)num key:(NSString *)aKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (nil == defaults || aKey == nil) {
        return;
    }
    [defaults setInteger:num forKey:aKey];
    [defaults synchronize];
}

+ (id)getLocalDataObject:(NSString *)aKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (nil == defaults || nil == aKey) {
        return nil;
    }
    
    id strRet = [defaults objectForKey:aKey];
    
    return strRet;
}

+ (void)setLocalDataObject:(id)aValue key:(NSString *)aKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (nil == defaults || nil == aKey) {
        return;
    }
    
    [defaults setValue:aValue forKey:aKey];
    [defaults synchronize];
}

static NSMutableDictionary* g_cacheDictKeyChain = nil;

// 设置keyChain数据
+ (void) setKeyChain:(NSString *)data key:(NSString *)aKay {
    
    if (nil == data || (nil != data && [data isKindOfClass:[NSString class]])) {
        [LYWUserKeyChainManager saveData:data key:aKay];
        
        if (g_cacheDictKeyChain == nil) {
            g_cacheDictKeyChain = [[NSMutableDictionary alloc] initWithCapacity:64];
        }
        
        if (g_cacheDictKeyChain && aKay) {
            if ( [g_cacheDictKeyChain objectForKey:aKay] ) {
                NSLog(@"remove data from g_cacheDictKeyChain2:%@ - %@", aKay, [g_cacheDictKeyChain objectForKey:aKay]);
                [g_cacheDictKeyChain removeObjectForKey:aKay];
            }
            
            if (data) {
                [g_cacheDictKeyChain setObject:data forKey:aKay];
                NSLog(@"set data to g_cacheDictKeyChain2:%@ - %@", aKay, data);
            }
        }
    }
}

//获得keyChain的通用数据
+ (NSString *)getKeyChain:(NSString *)aKay {
    NSString * data = nil;
    
    if (aKay) {
        
        if (g_cacheDictKeyChain == nil) {
            g_cacheDictKeyChain = [[NSMutableDictionary alloc] initWithCapacity:64];
        }
        
        data = [g_cacheDictKeyChain objectForKey:aKay];
        if (data) {
            
        } else {
            data = [LYWUserKeyChainManager loadData:aKay];
            if (data) {
                [g_cacheDictKeyChain setObject:data forKey:aKay];
                NSLog(@"set data to g_cacheDictKeyChain:%@ - %@", aKay, data);
            }
        }
    }
    return data;
}

//删除所有keyChin数据
+ (void)deleteAllKeyChain {
    
    [LYWUserKeyChainManager deleteAllData];
    if (g_cacheDictKeyChain) {
        [g_cacheDictKeyChain removeAllObjects];
        NSLog(@"remove all data from g_cacheDictKeyChain");
    }
}

#pragma mark - store common data

+ (NSString *)getUserID {
    NSString *data = [self getKeyChain:kDataStoreUID];
    if (data && [data isKindOfClass:[NSString class]]) {
        return data;
    }
    
    return @"";
}

+ (NSString *)getTempUserID {
    NSString *data = [self getKeyChain:kDataStoreTempUID];
    if (data && [data isKindOfClass:[NSString class]]) {
        return data;
    }
    
    return @"";
}

+ (NSString *)getUserPwd {
    NSString *data = [self getKeyChain:kDataStorePassword];
    if (nil != data && [data isKindOfClass:[NSString class]]) {
        return data;
    }
    
    return @"";
}

+ (NSString *)getEncryptUserPwd {
    NSString *pwd = [self getUserPwd];
    uint8_t epwd[256] = {0};
    
    RC4_s((uint8_t*)[pwd cStringUsingEncoding:NSASCIIStringEncoding], [pwd length], epwd);
    return [NSString stringWithCString:(char*)epwd encoding:NSASCIIStringEncoding];
}

+ (NSString *)getUserMobile {
    
    NSString *data = [self getKeyChain:kDataStorePhone];
    if (nil != data && [data isKindOfClass:[NSString class]]) {
        return data;
    }
    
    return @"";
}


#define Key_UserMobileFromNSUserDefaults @"Key_UserMobileFromNSUserDefaults"

#define Key_UserCountryNameFromNSUserDefaults @"Key_UserCountryNameFromNSUserDefaults"
#define Key_UserCountryCodeFromNSUserDefaults @"Key_UserCountryCodeFromNSUserDefaults"


+ (NSString *)getUserMobileFromNSUserDefaults {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    return [ud objectForKey:Key_UserMobileFromNSUserDefaults];
}
+ (NSString *)getRegistTimeFromNSUserDefaults {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    return [ud objectForKey:DATA_STORE_REGIEST_TIME];
}

+ (void)setUserMobileToNSUserDefaults:(NSString *)userMobile {
    if (userMobile) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:userMobile forKey:Key_UserMobileFromNSUserDefaults];
        [ud synchronize];
    }
}

+ (NSString *)getUserCountryNameFromNSUserDefaults {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    return [ud objectForKey:Key_UserCountryNameFromNSUserDefaults];
}

+ (void)setUserCountryNameToNSUserDefaults:(NSString *)countryName {
    if (countryName) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:countryName forKey:Key_UserCountryNameFromNSUserDefaults];
        [ud synchronize];
    }
}

+ (NSString *)getUserCountryCodeFromNSUserDefaults {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    return [ud objectForKey:Key_UserCountryCodeFromNSUserDefaults];
}

+ (void)setUserCountryCodeToNSUserDefaults:(NSString *)countryCode {
    if (countryCode) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:countryCode forKey:Key_UserCountryCodeFromNSUserDefaults];
        [ud synchronize];
    }
}

+ (void)setAC:(NSString *)strAC {
    [LYWUserDefaultManager setLocalDataString:strAC key:kDataStoreAC];
}

+ (void)setTempAC:(NSString *)strTempAC {
    [LYWUserDefaultManager setLocalDataString:strTempAC key:kDataStoreAC];
}

+ (NSString *)getAC {
    NSString *strAC = [LYWUserDefaultManager getLocalDataString:kDataStoreAC];
    if (!strAC || [strAC isKindOfClass:[NSNull class]]) {
        strAC = @"";
    }
    return strAC;
}

+ (NSString *)getTempAC {
    NSString *strTempAC = [LYWUserDefaultManager getLocalDataString:kDataStoreTempAC];
    if (!strTempAC || [strTempAC isKindOfClass:[NSNull class]]) {
        strTempAC = @"";
    }
    return strTempAC;
}

// 删除key
+ (void)removeLocalDataForKey:(NSString *)akey {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:akey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void)setUserDefaultWithCustomObject:(id)object key:(NSString *)key {
    
    if(key == nil || object == nil){
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)customObjectForKey:(NSString *)key {
    if(key == nil){
        return nil;
    }
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return object;
}

@end
