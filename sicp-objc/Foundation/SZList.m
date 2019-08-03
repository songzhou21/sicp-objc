//
//  SZList.m
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import "SZList.h"

@interface NSArray (SZExt)

- (nullable instancetype)sz_cdr;

@end

@interface SZPair ()


@property (nullable, nonatomic) id first;
@property (nullable, nonatomic) id last;

@end

@implementation SZPair

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![other isKindOfClass:[self class]]) {
        return NO;
    } else {
        SZPair *pair = other;
        
        if ([self.car isEqual:pair.car]) {

            if (self.cdr == nil &&
                pair.cdr == nil) {
                return YES;
            }
            
            if (self.cdr == nil ||
                pair.cdr == nil) {
                return NO;
            }
            
            return [self.cdr isEqual:pair.cdr];
        }
        
        return NO;
    }
}

- (NSUInteger)hash
{
    return [self.car hash] ^ [self.cdr hash];
}

+ (instancetype)cons:(id)first last:(id)last {
    SZPair *o = [SZPair new];
    o.first = first;
    o.last = last;
    
    return o;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> %@", [self class], self, self];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@, %@)", self.first ?: @"nil", self.last ?: @"nil"];
}

#pragma mark -
- (id)car {
    return self.first;
}

- (id)cdr {
    return self.last;
}

- (NSInteger)length {
    return [self lengthWithItems:self];
}

// (cons 1 (cons 2 nil)) == 2
- (NSInteger)lengthWithItems:(SZPair *)items {
    if (items == nil) {
        return 0;
    } else {
        return 1 + [self lengthWithItems:[items cdr]];
    }
}

- (SZPair *)lastPair {
    return [self lastPairWithItems:self];
}

- (SZPair *)lastPairWithItems:(SZPair *)items {
    if ([items cdr] == nil) {
        return items;
    }
    
    return [self lastPairWithItems:[items cdr]];
}

- (SZPair *)objectAtIndex:(NSInteger)index {
    return [self objectAtIndex:index items:self];
}

- (SZPair *)objectAtIndex:(NSInteger)index items:(SZPair *)items {
    if (index == 0) {
        return [items car];
    } else {
        return [self objectAtIndex:index-1 items:[items cdr]];
    }
}

#pragma mark -
- (SZPair *)map:(SZPairMapBlock)block {
    NSParameterAssert(block);
    
    return [self map:block items:self];
}

- (SZPair *)map:(SZPairMapBlock)block items:(SZPair *)items {
    if (!items) {
        return nil;
    } else {
        return [SZPair cons:block([items car])
                       last:[self map:block items:[items cdr]]];
    }
}

- (void)forEach:(SZPairAccessBlock)block {
    NSParameterAssert(block);
    
    [self forEach:block items:self];
}

- (void)forEach:(SZPairAccessBlock)block items:(SZPair *)items {
    if (items) {
        block([items car]);
        [self forEach:block items:[items cdr]];
    }
}

- (SZPair *)filter:(SZPairFilterBlock)block {
    NSParameterAssert(block);
    return [self filter:block items:self];
}


- (SZPair *)filter:(SZPairFilterBlock)block items:(SZPair *)items {
    if (!items) {
        return nil;
    } else if (block([items car])) {
        return [SZPair cons:[items car]
                       last:[self filter:block items:[items cdr]]];
    } else {
        return [self filter:block items:[items cdr]];
    }
}

- (SZPair *)reverse {
    return [self reverseWithItems:self result:nil];
}

/**
(reverse-iter (list 1 4 9 16 25) nil)
(reverse-iter (list 4 9 16 25) (cons 1 nil))
(reverse-iter (list 9 16 25) (cons 4 (cons 1 nil))))
 */
- (SZPair *)reverseWithItems:(SZPair *)items result:(SZPair *)result {
    if (!items) {
        return result;
    } else{
        return [self reverseWithItems:[items cdr]
                        result:[SZPair cons:[items car]
                                       last:result]];
    }
}

- (SZPair *)memq:(SZPair *)pair {
    return [self memq:pair list:self];
}

- (SZPair *)memq:(SZPair *)pair list:(SZPair *)list {
    if (!list) {
        return nil;
    }
    
    if ([pair isEqual:[list car]]) {
        return list;
    } else {
        return [self memq:pair list:[list cdr]];
    }
}

@end

#pragma mark - List
static SZPair *makePairWithArray(NSArray *array) {
    if (array.count == 0) {
        return nil;
    }
    
    return [SZPair cons:array.firstObject last:makePairWithArray([array sz_cdr])];
}


SZPair *SZList(NSArray *array) {
    return makePairWithArray(array);
}


SZPair *SZListAppend(SZPair *list1, SZPair *list2) {
    if (!list1) {
        return list2;
    } else {
        return [SZPair cons:[list1 car] last:SZListAppend([list1 cdr], list2)];
    }
}

@implementation NSArray (SZExt)

- (instancetype)sz_cdr {
    return self.count > 1 ? [self subarrayWithRange:NSMakeRange(1, self.count-1)] : nil;
}

@end
