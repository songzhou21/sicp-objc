//
//  SZCelsiusFahrenheitConverter.h
//  sicp-objc
//
//  Created by songzhou on 2019/8/3.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZConnector.h"
#import "SZConstraint.h"

NS_ASSUME_NONNULL_BEGIN

@interface SZCelsiusFahrenheitConverter : NSObject

@property (nonatomic) SZConnector *u;
@property (nonatomic) SZConnector *v;
@property (nonatomic) SZConnector *w;
@property (nonatomic) SZConnector *x;
@property (nonatomic) SZConnector *y;


@property (nonatomic) SZMultiplierConstraint *multiplier1;
@property (nonatomic) SZMultiplierConstraint *multiplier2;
@property (nonatomic) SZAdderConstraint *adder;
@property (nonatomic) SZConstantConstraint *constant9;
@property (nonatomic) SZConstantConstraint *constant5;
@property (nonatomic) SZConstantConstraint *constant32;

- (instancetype)initWithC:(SZConnector *)c f:(SZConnector *)f;

@end

NS_ASSUME_NONNULL_END
