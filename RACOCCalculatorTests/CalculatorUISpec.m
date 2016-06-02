//
//  CalculatorUISpec.m
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <KIF/KIF.h>

#import "TestRootViewSetup.h"


SpecBegin(CalculatorUI)

describe(@"Calculator", ^{
  
  __block CalculatorViewController *calculatorVC;
  __block NSTimeInterval originalTimeout;

  beforeAll(^{
    calculatorVC = [TestRootViewSetup setupForCalculator];
    
    originalTimeout = [KIFTestActor defaultTimeout];
    [KIFTestActor setDefaultTimeout:0.01];
  });
  
  beforeEach(^{
    [calculatorVC resetCalculater];
  });

  context(@"when it is initialized", ^{
    
    afterAll(^{
      [KIFTestActor setDefaultTimeout:originalTimeout];
    });
    
    it(@"should show the UI element 0", ^{
      [tester waitForViewWithAccessibilityLabel:@"0"];
    });
    it(@"should show the UI element 1", ^{
      [tester waitForViewWithAccessibilityLabel:@"1"];
    });
    it(@"should show the UI element 2", ^{
      [tester waitForViewWithAccessibilityLabel:@"2"];
    });
    it(@"should show the UI element 3", ^{
      [tester waitForViewWithAccessibilityLabel:@"3"];
    });
    it(@"should show the UI element 4", ^{
      [tester waitForViewWithAccessibilityLabel:@"4"];
    });
    it(@"should show the UI element 5", ^{
      [tester waitForViewWithAccessibilityLabel:@"5"];
    });
    it(@"should show the UI element 6", ^{
      [tester waitForViewWithAccessibilityLabel:@"6"];
    });
    it(@"should show the UI element 7", ^{
      [tester waitForViewWithAccessibilityLabel:@"7"];
    });
    it(@"should show the UI element 8", ^{
      [tester waitForViewWithAccessibilityLabel:@"8"];
    });
    it(@"should show the UI element 9", ^{
      [tester waitForViewWithAccessibilityLabel:@"9"];
    });
    it(@"should show the UI element decimal point", ^{
      [tester waitForViewWithAccessibilityLabel:@"."];
    });
    it(@"should show the UI element plus sign", ^{
      [tester waitForViewWithAccessibilityLabel:@"+"];
    });
    it(@"should show the UI element minus sign", ^{
      [tester waitForViewWithAccessibilityLabel:@"-"];
    });
    it(@"should show the UI element multipl sign", ^{
      [tester waitForViewWithAccessibilityLabel:@"*"];
    });
    it(@"should show the UI element division sign", ^{
      [tester waitForViewWithAccessibilityLabel:@"/"];
    });
    it(@"should show the UI element equal sign", ^{
      [tester waitForViewWithAccessibilityLabel:@"="];
    });
    it(@"should show the UI element clean button", ^{
      [tester waitForViewWithAccessibilityLabel:@"C"];
    });
    it(@"should show the UI element percentage sign", ^{
      [tester waitForViewWithAccessibilityLabel:@"%"];
    });
    it(@"should show the UI element plus or minus sign", ^{
      [tester waitForViewWithAccessibilityLabel:@"±"];
    });
    it(@"should show the UI element display", ^{
      [tester waitForViewWithAccessibilityLabel:@"display"];
    });
  });

});

SpecEnd