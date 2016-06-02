//
//  Calculation.m
//  RACOCCalculator
//
//  Created by Xaree on 6/1/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import "Calculation.h"

NSString const *CalculatorError = @"Error";

NSString *stringValueForDisplay(RACTuple *state) {
  return state[2] ?: state[0] ?: @"0";
}

RACTuple *calculatorState(NSString *ans, NSString *c_op, NSString *c_ip, NSString *l_op, NSString *acc) {
  return RACTuplePack(ans, c_op, c_ip, l_op, acc);
}

RACTuple *initialCalculatorState() {
  return RACTuplePack(nil, nil, nil, nil, nil);
}

RACTuple *handleInputForCalculatorState(RACTuple *state, NSString *input) {
  
  state = state ?: initialCalculatorState();
  RACTuple *nextState = nil;
  
  if ([@"0123456789.±%" containsString:input]) {
    nextState = updateInputValueState(state, input);
  }
  if ([@"+-*/=" containsString:input]) {
    nextState = calculateState(state, input);
  }
  if ([input isEqualToString:@"C"]) {
    nextState = initialCalculatorState();
  }
  
  debug_and_test_only(^{
    printf("(%s): %s -> %s\n", input.UTF8String, state.stateDescription.UTF8String, nextState.stateDescription.UTF8String);
  });
  
  return nextState;
}

RACTuple *handleInputSequenceForCalculatorState(RACTuple *state, NSString *sequence, StepCalculatorState stepStateBlock) {
  
  __block RACTuple *currentState = state;
  
  [sequence enumerateSubstringsInRange:NSMakeRange(0, sequence.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable input, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
    
    currentState = handleInputForCalculatorState(currentState, input);
    
    if (stepStateBlock) {
      stepStateBlock(input, currentState);
    }
  }];
  
  return currentState;
}


#pragma mark - 

static id calculate(NSString *value, NSString *op, NSString *input) {
  if (!value || !op || !input) {
    return input ?: value;
  }
  
  NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:value];
  NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:input];
  
  if ([op isEqualToString:@"+"] ) {
    return [[num1 decimalNumberByAdding:num2] stringValue];
  }
  if ([op isEqualToString:@"-"]) {
    return [[num1 decimalNumberBySubtracting:num2] stringValue];
  }
  if ([op isEqualToString:@"*"]) {
    return [[num1 decimalNumberByMultiplyingBy:num2] stringValue];
  }
  if ([op isEqualToString:@"/"] && num2 != 0) {
    return ([num2 isEqualToNumber:[NSDecimalNumber zero]]
            ? CalculatorError
            : [[num1 decimalNumberByDividingBy:num2] stringValue]);
  }
  printf("undefined calculation => v1: %s, op: %s, v2: %s\n", value.UTF8String, op.UTF8String, input.UTF8String);
  return CalculatorError;
}

// Accept operation: [+-*/=]
RACTuple *calculateState(RACTuple *state, NSString *new_op) {
  // We use tuple to represent the calculator states `(ans, c_op, c_ip, l_op, acc)` :
  //
  // * ans: the answer of the previous calculation
  // * c_op: the current operator input
  // * c_ip: the current value input
  // * l_op: the latest valid operator
  // * acc: the value for accumulated calculation (repeated `=`).
  
  RACTupleUnpack(NSString *ans, NSString *c_op, NSString *c_ip, NSString *l_op, NSString *acc) = state;
  
  // Calculate the results. We have different behavior between `=` and `+-*/`
  // operators.
  //
  // Note: the `calculate()` will return current input or if there is no operator.
  if ([new_op isEqualToString:@"="]) {
    // * If previous answer is an `Error`, the result is `Error`.
    // * Try calculate the result using previous operator and input value if needed.
    // * Assign the current operator to `nil`, not `=`.
    // * Record the operator and input for the calculation in the previous states.
    NSString *result = ([ans isEqualToString:(NSString *)CalculatorError]
                        ? (NSString *)CalculatorError
                        : calculate(ans, c_op?:l_op, c_ip?:acc));
    return RACTuplePack(result, nil, nil, c_op?:l_op, c_ip?:acc);
    
  } else {
    // * If previous answer is an `Error`, simply assign current input to the result.
    // * If current input is nil, keep the previous answer as the result.
    // * Record the result in accumulated value.
    NSString *result = ([ans isEqualToString:(NSString *)CalculatorError]
                        ? c_ip
                        : (c_ip
                           ? calculate(ans, c_op, c_ip)
                           : ans));
    return RACTuplePack(result, new_op, nil, c_op, result);
  }
}

NSString *changeSignOfNumberString(NSString *numberString) {
  NSString *minusSign = @"-";
  return ([numberString hasPrefix:minusSign]
          ? [numberString substringFromIndex:1]
          : [minusSign stringByAppendingString:numberString]);
}

NSString *percentageOfNumberString(NSString *numberString) {
  return [@([numberString doubleValue] / 100.0) stringValue];
}

NSString *combineCalculatorInputs(NSString *currentInput, NSString *nextInput) {
  
  if (!currentInput) {
    return [nextInput isEqualToString:@"."] ? @"0." : nextInput;
  }
  if ([currentInput containsString:@"."] && [nextInput isEqualToString:@"."]) {
    return currentInput;
  }
  if ([currentInput isEqualToString:@"0"] && ![nextInput isEqualToString:@"."]) {
    return nextInput;
  }
  
  return [currentInput stringByAppendingString:nextInput];
}

// Accept input: [0-9.±%]
RACTuple *updateInputValueState(RACTuple *state, NSString *input) {
  NSString *current_input = state[2];
  NSString *new_input;
  if ([input isEqualToString:@"±"]) {
    new_input = changeSignOfNumberString(current_input);
  } else if ([input isEqualToString:@"%"]) {
    new_input = percentageOfNumberString(current_input);
  } else {
    new_input = combineCalculatorInputs(current_input, input);
  }
  return RACTuplePack(state[0], state[1], new_input, state[3], state[4]);
}

#pragma mark -

@implementation RACTuple (StateDescription)
- (NSString *)stateDescription {
  return [NSString stringWithFormat:@"(%@, %@, %@, %@, %@)",
          self[0]?:@"nil",
          self[1]?:@"nil",
          self[2]?:@"nil",
          self[3]?:@"nil",
          self[4]?:@"nil"];
}
@end
