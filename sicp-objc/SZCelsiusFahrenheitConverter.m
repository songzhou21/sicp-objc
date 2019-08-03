//
//  SZCelsiusFahrenheitConverter.m
//  sicp-objc
//
//  Created by songzhou on 2019/8/3.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import "SZCelsiusFahrenheitConverter.h"

@implementation SZCelsiusFahrenheitConverter

- (instancetype)initWithC:(SZConnector *)c f:(SZConnector *)f {
    self = [super init];
    if (self) {
        _u = [SZConnector new];
        _v = [SZConnector new];
        _w = [SZConnector new];
        _x = [SZConnector new];
        _y = [SZConnector new];
        
        _multiplier1 = [SZMultiplierConstraint constraintWithM1:c a2:_w product:_u];
        _multiplier2 = [SZMultiplierConstraint constraintWithM1:_v a2:_x product:_u];
        _adder = [SZAdderConstraint constraintWithA1:_v a2:_y sum:f];
        _constant9 = [SZConstantConstraint constraintWithValue:@9 connector:_w];
        _constant5 = [SZConstantConstraint constraintWithValue:@5 connector:_x];
        _constant32 = [SZConstantConstraint constraintWithValue:@32 connector:_y];
    }
    return self;
}
@end
