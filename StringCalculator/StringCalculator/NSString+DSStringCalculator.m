#import "NSString+DSStringCalculator.h"

@implementation NSString (DSStringCalculator)

+(NSInteger)Add:(NSString*)numbers {
    NSInteger sum = 0;
    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@",\n"];
    NSArray* strValues = [numbers componentsSeparatedByCharactersInSet:delimiters];
    for (NSString *strValue in strValues) {
        sum += [strValue integerValue];
    }
    return sum;
}

@end
