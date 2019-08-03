//
//  SZList.h
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef id _Nullable (^SZPairMapBlock)(id item);
typedef void (^SZPairAccessBlock)(id item);
typedef BOOL (^SZPairFilterBlock)(id item);

@class SZPair;
extern SZPair *SZList(NSArray *array);
extern SZPair *SZListAppend(SZPair *list1, SZPair *list2);

@interface SZPair : NSObject

+ (instancetype)cons:(nullable id)first last:(nullable id)last;

#pragma mark - Accessor
- (nullable id)car;
- (nullable id)cdr;

/// O(n)
- (NSInteger)length;
- (SZPair *)lastPair;

/// O(n)
- (SZPair *)objectAtIndex:(NSInteger)index;


#pragma mark - Operations
- (SZPair *)map:(SZPairMapBlock)block;
- (void)forEach:(SZPairAccessBlock)block;
- (SZPair *)filter:(SZPairFilterBlock)block;

- (SZPair *)reverse;

#pragma mark - Search
/**
 scheme memq
 
 pair: (cons a '())
 self: (cons b (cons (cons a '()) (cons c '())))
 return: (cons (cons a '()) (cons c '()))
 
 memq uses `isEqual:` to compare object with the elements of list
 
 @param pair pair
 @return the first pair of self whose car is pair
 */
- (nullable SZPair *)memq:(SZPair *)pair;

@end

NS_INLINE SZPair *SZCons(id first,  id _Nullable last) {
    return [SZPair cons:first last:last];
}

NS_ASSUME_NONNULL_END
