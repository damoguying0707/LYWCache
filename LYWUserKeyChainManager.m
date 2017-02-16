//
//  WQUserDataManager.m
//  KeyChain
//
//  Created by vincent.li on 7/10/15.
//

#import "LYWUserKeyChainManager.h"
#import "KeyChain.h"

@implementation LYWUserKeyChainManager

#define kKeyChainService [NSString stringWithFormat:@"%@.allinfo", kBundleID]

+ (void)saveData:(NSString *)data key:(NSString *)key {
    if (!data) {
        data = @"";
    }
    
    NSMutableDictionary *dict = (NSMutableDictionary *)[KeyChain load:kKeyChainService];
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
    }
    
    [dict setObject:data forKey:key];
    [KeyChain save:kKeyChainService data:dict];
}

+ (NSString *)loadData:(NSString *)key {
    NSMutableDictionary *dict = (NSMutableDictionary *)[KeyChain load:kKeyChainService];
    if (!dict) {
        return nil;
    }
    
    return dict[key];
}

+ (void)deleteData:(NSString *)key {
    NSMutableDictionary *dict = (NSMutableDictionary *)[KeyChain load:kKeyChainService];
    if (dict) {
        [dict removeObjectForKey:key];
    } else {
        dict = [NSMutableDictionary dictionary];
    }
    
    [KeyChain save:kKeyChainService data:dict];
}

+ (void)deleteAllData {
    [KeyChain delete:kKeyChainService];
}

@end
