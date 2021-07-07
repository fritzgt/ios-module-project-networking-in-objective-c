//
//  FGTDailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by FGT MAC on 7/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"


@interface FGTDailyWeatherTests : XCTestCase

@end

@implementation FGTDailyWeatherTests

- (void)testJsonData
{

//    NSData *data = [LSIFileHelper loadData];
}

- (void)testPlayground
{
    int (^largestInteger)(int,int,int) = ^(int a, int b, int c) {
        //Check for the largest int
        int largest = a;
        if(a < b) {
            largest = b;
        }else if (a < c){
            largest = c;
        }
        
        return largest;
    };
    
    int result = largestInteger(55, -3, 409);
    NSLog(@"Higest value= %i",result);
    XCTAssertTrue(result == 409);
}

-(void)testBlock
{
    int(^performMath)(int a, int b) = ^int(int a, int b){
        return a + b;
    };
    
    int result = performMath(5,4);
    NSLog(@"%d",result);
};


@end
