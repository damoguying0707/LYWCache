
#import <Foundation/Foundation.h>

//账户登录状态判断，略复杂：
//临时登录，uid / temp_uid 不为空，且 uid == temp_uid，password 不一定为空
//已登录，uid / password 不为空，temp_uid 不一定为空，也不一定等于 uid
//未登录，其他情况

extern NSString * const kDataStoreUID;          // 当前用户ID，正式的（当用户正常登录时）或临时的（当用户临时登录时）
extern NSString * const kDataStoreTempUID;      // 临时用户ID
extern NSString * const kDataStorePassword;     // 密码
extern NSString * const kDataStorePhone;        // 绑定的手机号码
extern NSString * const kDataStoreAC;           // 登录返回的ac，取代ssid
extern NSString * const kDataStoreTempAC;       // 临时ac


@interface LYWUserDefaultManager : NSObject

#pragma mark - common fun

/**
 *  从本地数据库获对应key值下的数据(字符串)
 */
+ (NSString *)getLocalDataString:(NSString *)aKey;

/**
 *  设置本地数据库对应key值下的数据(字符串)
 */
+ (void)setLocalDataString:(NSString *)aValue key:(NSString *)aKey;

/**
 *  从本地数据库获对应key值下的数据(bool)
 */
+ (BOOL)getLocalDataBoolen:(NSString *)aKey;

/**
 *  设置本地数据库对应key值下的数据(bool)
 */
+ (void)setLocalDataBoolen:(BOOL)bValue key:(NSString *)aKey;

/**
 *  从本地数据库获对应key值下的数据(int)
 */
+ (NSInteger)getLocalDataInt:(NSString *)aKey;

/**
 *  从本地数据库获得对应key值下的数据（CGfloat）
 */
+ (CGFloat)getLocalDataCGfloat:(NSString *)aKey;

/**
 *  设置本地数据库对应key值下的数据(CGfloat)
 */
+ (void)setLocalDataCGfloat:(CGFloat)num key:(NSString *)aKey;

/**
 *  设置本地数据库对应key值下的数据(int)
 */
+ (void)setLocalDataInt:(NSInteger)num key:(NSString *)aKey;

/**
 *  从本地数据库获对应key值下的(object)
 */
+ (id)getLocalDataObject:(NSString *)aKey;

/**
 *  设置本地数据库对应key值下的数据(字object串)
 */
+ (void)setLocalDataObject:(id)aValue key:(NSString *)aKey;

/**
 *  设置keyChain数据
 */
+ (void)setKeyChain:(NSString *)data key:(NSString *)aKay;

/**
 *  获得keyChain的通用数据
 */
+ (NSString *)getKeyChain:(NSString *)aKay;

/**
 *  删除所有keyChin数据
 */
+ (void)deleteAllKeyChain;

#pragma mark - store common data

/**
 *  从本地数据库获取当前用户ID，有可能是正式用户ID（当用户已登录时）或临时用户ID（当用户临时登录时）
 */
+ (NSString *)getUserID;

/**
 *  从本地数据库获取临时用户ID
 */
+ (NSString *)getTempUserID;

/**
 *  从本地数据库获取用户密码
 */
+ (NSString *)getUserPwd;

/**
 *  获取加密的用户密码，在HTTP协议中使用
 */
+ (NSString*)getEncryptUserPwd;

/**
 *  从本地数据库获取用户手机号码
 */
+ (NSString *)getUserMobile;

/**
 * 用于退出登录时记住手机号码，登录页面需要用到
 */
+ (NSString *)getUserMobileFromNSUserDefaults;

/**
 * 用于退出登录时记住手机号码，登录页面需要用到
 */
+ (void)setUserMobileToNSUserDefaults:(NSString *)userMobile;

/**
 * 用于记住登录成功的用户的国家名称
 */
+ (NSString *)getUserCountryNameFromNSUserDefaults;

/**
 *用于记住用户注册时间
*/
+ (NSString *)getRegistTimeFromNSUserDefaults;

/**
 * 用于记住登录成功的用户的国家名称
 */
+ (void)setUserCountryNameToNSUserDefaults:(NSString *)countryName;

/**
* 用于记住登录成功的用户的国家区号
*/
+ (NSString *)getUserCountryCodeFromNSUserDefaults;

/**
* 用于记住登录成功的用户的国家区号
*/
+ (void)setUserCountryCodeToNSUserDefaults:(NSString *)countryCode;

/**
 *  set ac
 */
+ (void)setAC:(NSString *)strAC;

/**
 *  set temp ac
 */
+ (void)setTempAC:(NSString *)strTempAC;

/**
 *  get ac
 */
+ (NSString *)getAC;

/**
 *  get ac
 */
+ (NSString *)getTempAC;

/**
 *  删除key
 */
+ (void)removeLocalDataForKey:(NSString *)akey;



+ (void)setUserDefaultWithCustomObject:(id)object key:(NSString *)key;

+ (id)customObjectForKey:(NSString *)key;

@end
