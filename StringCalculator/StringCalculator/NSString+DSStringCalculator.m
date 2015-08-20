#import "NSString+DSStringCalculator.h"

@implementation NSString (DSStringCalculator)

+(NSString*)parseNumbersString:(NSString*)numbers forDelimiters:(NSCharacterSet**)delimiters {
    NSMutableCharacterSet *tmpDelimiters = [NSMutableCharacterSet characterSetWithCharactersInString:@",\n"];
    if ( numbers.length>2 && [[numbers substringToIndex:2] isEqualToString:@"//"]) {
        [tmpDelimiters addCharactersInString:[numbers substringWithRange:NSMakeRange(2, 1)]];
        numbers = [numbers substringFromIndex:3];
    }
    *delimiters = (NSCharacterSet*)[tmpDelimiters copy];
    return numbers;
}

+(NSInteger)Add:(NSString*)numbers {
    NSInteger sum = 0;
    NSCharacterSet *delimiters = nil;
    numbers = [NSString parseNumbersString:numbers forDelimiters:&delimiters];
    NSArray* strValues = [numbers componentsSeparatedByCharactersInSet:delimiters];
    for (NSString *strValue in strValues) {
        sum += [strValue integerValue];
    }
    return sum;
}

@end
