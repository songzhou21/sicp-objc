//
//  SZConnector.m
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import "SZConnector.h"
#import "SZList.h"
#import "SZConstraint.h"

@interface SZConnector ()

@property (nonatomic) NSNumber *value;
@property (nonatomic) id informant;
@property (nonatomic) SZPair *constraints;

@property (nonatomic, copy) id informAboutValue;
@property (nonatomic, copy) id informAboutNoValue;

@end


@implementation SZConnector

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.informant = @(NO);
    _informAboutValue = ^void(SZConstraint *constraint) {
        [constraint processNewValue];
    };
    _informAboutNoValue = ^void(SZConstraint *constraint) {
        [constraint processForgetValue];
    };
    
    return self;
}


- (void)setValue:(NSNumber *)value informant:(id)informant {
    if (![self hasValue]) {
        self.value = value;
        self.informant = informant;
        [self forEachExcept:informant
                      block:self.informAboutValue
                       list:self.constraints];
        
    } else if (self.value != value){
       [NSException exceptionWithName:NSGenericException
                               reason:[NSString stringWithFormat:@"Contradiction: %@", SZList(@[self.value, value])]
                             userInfo:nil];
    }
}


- (void)forgetValueWithRetractor:(id)retractor {
    if ([self.informant isEqual:retractor]) {
        self.informant = @(NO);
        [self forEachExcept:retractor
                      block:self.informAboutNoValue
                       list:self.constraints];
    }
}

- (void)connectWithNewConstraint:(id)constraint {
    if (![constraint memq:self.constraints]) {
        self.constraints = SZCons(constraint, self.constraints);
    }
}

- (BOOL)hasValue {
    return self.informant != nil;
}

#pragma mark - Private
- (void)forEachExcept:(id)exception block:(void(^)(id))block list:(SZPair *)list {
    [list forEach:^(id  _Nonnull item) {
        if ([item isEqual:exception]) {
            return;
        }
        
        block(item);
    }];
}

@end
