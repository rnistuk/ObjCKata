#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "NSString+DSStringCalculator.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAddMethodCreated {
    //1) Create a simple String Calculator with a method  int Add(string numbers)
    XCTAssert([NSString respondsToSelector:@selector(Add:)], @"Pass");
}

- (void)testAddUpToThreeIntegers {
    // The method can take 0, 1 or 2 numbers, and will return their sum (for an
    // empty string it will return 0) for example “” or “1” or “1,2”
    XCTAssertEqual(0, [NSString Add:@""]);
    XCTAssertEqual(1, [NSString Add:@"1"]);
}



@end
