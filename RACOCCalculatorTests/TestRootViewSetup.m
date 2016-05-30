//
//  SetupViewController.m
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import "TestRootViewSetup.h"
#import "AppDelegate.h"


@implementation TestRootViewSetup

+ (CalculatorViewController *)setupForCalculator {
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  CalculatorViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CalculatorView"];
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  appDelegate.window.rootViewController = vc;
  return vc;
}

@end
