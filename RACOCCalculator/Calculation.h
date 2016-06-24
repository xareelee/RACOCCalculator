//
//  Calculation.h
//  RACOCCalculator
//
//  Created by Xaree on 6/1/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@class CalculatorState;

extern NSString const *CalculatorError;

typedef void(^StepCalculatorState)(NSString *input, RACTuple *stepResultState);


#pragma mark -

/// Tranform calculator state to tuple
RACTuple *tupleForState(CalculatorState *state);

/// Transform tuple to calculator state
CalculatorState *stateForTuple(RACTuple *tuple);

/// Return the new state for the input to combine the current state.
CalculatorState *combineInputIntoCalculatorState(NSString *input, CalculatorState *state);

#pragma mark -

NSString *stringValueForDisplay(CalculatorState *state);

/// A helper constructor to return a tuple to represent a calculator state.
///
/// @param ans: the answer of the previous calculation
/// @param c_op: the current operator input
/// @param c_ip: the current value input
/// @param l_op: the latest valid operator
/// @param acc: the value for accumulated calculation (repeated `=`).
///
/// @return A tuple to represent a calculator state (ans, c_op, c_ip, l_op, acc)
RACTuple *calculatorState(NSString *ans, NSString *c_op, NSString *c_ip, NSString *l_op, NSString *acc);

/// Give a state an input to return a new state
RACTuple *handleInputForCalculatorState(RACTuple *state, NSString *input);

/// Give a state an input sequence to return a new state. You can evaluate each
/// step result state.
RACTuple *handleInputSequenceForCalculatorState(RACTuple *state, NSString *sequence, StepCalculatorState stepStateBlock);


#pragma mark - 

/// Accept input: [0-9.±%]
RACTuple *updateInputValueState(RACTuple *state, NSString *input);

/// Accept operation: [+-*/=]
RACTuple *calculateState(RACTuple *state, NSString *new_op);

/// @return a combined input value
NSString *combineCalculatorInputs(NSString *currentInput, NSString *nextInput);


#pragma mark - 
@interface RACTuple (StateDescription)
- (NSString *)stateDescription;
@end

