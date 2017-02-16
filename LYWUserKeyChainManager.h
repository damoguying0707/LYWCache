
//  Created by vincent.li on 7/10/15.
//

#import <Foundation/Foundation.h>

@interface LYWUserKeyChainManager : NSObject

/**
*  存储数据
*
*  @param data 数据
*  @param key  键
*/
+ (void)saveData:(NSString *)data key:(NSString *)key;

/**
 *  加载数据
 *
 *  @param key 键
 *
 *  @return 数据
 */
+ (id)loadData:(NSString *)key;

/**
 *  删除数据
 *
 *  @param key 键
 */
+ (void)deleteData:(NSString *)key;

/**
 *  删除所有数据
 */
+ (void)deleteAllData;

@end
