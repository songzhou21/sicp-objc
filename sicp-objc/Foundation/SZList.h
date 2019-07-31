//
//  SZList.h
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZPair : NSObject

+ (instancetype)cons:(nullable id)first last:(nullable id)last;

- (nullable id)car;
- (nullable id)cdr;

/// O(n)
- (NSInteger)length;

@end

@interface SZList : NSObject

+ (SZPair *)new:(NSArray *)array;

+ (SZPair *)append:(SZPair *)list1 list2:(SZPair *)list2;

@end

NS_ASSUME_NONNULL_END
