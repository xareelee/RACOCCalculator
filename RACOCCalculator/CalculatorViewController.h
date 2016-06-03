//
//  ViewController.h
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>



@interface CalculatorViewController : UIViewController

- (void)resetCalculater;
- (void)resetCalculaterWithState:(RACTuple *)state;

@end

