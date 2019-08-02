//
//  SZConstraints.h
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZConnector.h"

NS_ASSUME_NONNULL_BEGIN

/**
 sicp 3.3.5 Propagation of Constraints Objective-C implementation
 */

@protocol SZConstraint <NSObject>

@optional
- (void)processNewValue;
- (void)processForgetValue;

@end

@interface SZConstraint : NSObject<SZConstraint>

+ (instancetype)probeWithName:(NSString *)name connector:(SZConnector *)connector;

- (void)processNewValue;
- (void)processForgetValue;

@end

@interface SZAdderConstraint : NSObject<SZConstraint>

+ (instancetype)constraintWithA1:(SZConnector *)a1 a2:(SZConnector *)a2 sum:(SZConnector *)sum;

- (void)processNewValue;
- (void)processForgetValue;

@end

@interface SZMultiplierConstraint : NSObject<SZConstraint>

+ (instancetype)constraintWithM1:(SZConnector *)m1 a2:(SZConnector *)m2 product:(SZConnector *)product;

- (void)processNewValue;
- (void)processForgetValue;

@end

@interface SZConstantConstraint : NSObject<SZConstraint>

+ (instancetype)constraintWithValue:(NSNumber *)value connector:(SZConnector *)connector;

@end

NS_ASSUME_NONNULL_END

