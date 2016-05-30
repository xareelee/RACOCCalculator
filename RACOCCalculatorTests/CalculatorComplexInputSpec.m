//
//  CalculatorSpec.m
//  RACObjCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <KIF/KIF.h>

#import "TestRootViewSetup.h"
#import "TestHelper.h"

SpecBegin(CalculatorComplexInput)

describe(@"Calculator", ^{
  
  __block CalculatorViewController *calculatorVC;
  
  beforeAll(^{
    calculatorVC = [TestRootViewSetup setupForCalculator];
  });
  
  beforeEach(^{
    [calculatorVC resetCalculater];
  });
  
  context(@"for any integer input", ^{
    
    it(@"should show 123 when tapping sequence is 123", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"123" expectedResult:@"123"];
    });
    
    it(@"should show 20987654321 when tapping sequence is 20987654321", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"20987654321" expectedResult:@"20987654321"];
    });
    
  });
  
  context(@"for multiple zeros input", ^{
    
    it(@"should show 0 when tapping sequence is 000000", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"000000" expectedResult:@"0"];
    });
    
  });
  
  context(@"for floating number input", ^{
    
    it(@"should show 0. when tapping sequence is 0.", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"0." expectedResult:@"0."];
    });
    
    it(@"should show 0.00000 when tapping sequence is 0.00000", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"0.00000" expectedResult:@"0.00000"];
    });
    
    it(@"should show 0.000001024 when tapping sequence is 0.000001024", ^{
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"0.000001024" expectedResult:@"0.000001024"];
    });
    
  });
  
  context(@"for enter and clean multiple inputs", ^{
    
    it(@"should be able to clean and enter inputs with multiple times", ^{
      
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"123" expectedResult:@"123"];
      
      [tester tapViewWithAccessibilityLabel:@"C"];
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"1" expectedResult:@"1"];
      
      [tester tapViewWithAccessibilityLabel:@"C"];
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"987654321" expectedResult:@"987654321"];
      
      [tester tapViewWithAccessibilityLabel:@"C"];
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"345.6789012" expectedResult:@"345.6789012"];
      
      [tester tapViewWithAccessibilityLabel:@"C"];
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"0.000" expectedResult:@"0.000"];
      
      [tester tapViewWithAccessibilityLabel:@"C"];
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"0.000123" expectedResult:@"0.000123"];
      
      [tester tapViewWithAccessibilityLabel:@"C"];
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"965123.0002" expectedResult:@"965123.0002"];
      
      [tester tapViewWithAccessibilityLabel:@"C"];
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"965123." expectedResult:@"965123."];
      
      [tester tapViewWithAccessibilityLabel:@"C"];
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"987654321" expectedResult:@"987654321"];

      [tester tapViewWithAccessibilityLabel:@"C"];
      [tester typeCalculatorWithExpectedStartValue:@"0" sequence:@"00077890" expectedResult:@"77890"];

    });
    
  });
  
});

SpecEnd