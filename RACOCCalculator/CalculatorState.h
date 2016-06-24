//
//  CalculatorState.h
//  RACOCCalculator
//
//  Created by Xaree on 6/24/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorState : NSObject

/// The answer of the previous calculation.
@property (strong, nonatomic, readonly) NSString *ans;

/// The current value input.
@property (strong, nonatomic, readonly) NSString *c_ip;

/// The current operator input.
@property (strong, nonatomic, readonly) NSString *c_op;

/// The latest valid operator.
@property (strong, nonatomic, readonly) NSString *l_op;

/// The value for accumulated calculation (for repeating `=` calculation).
@property (strong, nonatomic, readonly) NSString *acc;

/// Create a new state for given values.
+ (instancetype)stateWithAnswer:(NSString *)ans currentOperator:(NSString *)c_op currentInput:(NSString *)c_ip latestOperator:(NSString *)l_op accumulatedValue:(NSString *)acc;

/// A state with null values.
+ (instancetype)initialState;


@end
