#import "NSString+DSStringCalculator.h"

@implementation NSString (DSStringCalculator)

+(NSInteger)Add:(NSString*)numbers {
    NSInteger sum = 0;
    NSMutableCharacterSet *delimiters = [NSMutableCharacterSet characterSetWithCharactersInString:@",\n"];
    NSString* options = [[numbers componentsSeparatedByString:@"\n"] objectAtIndex:0];
    if (options && options.length>2) {
        if ([[options substringToIndex:2] isEqualToString:@"//"]) {
            [delimiters addCharactersInString:[options substringFromIndex:2]];
            numbers = [numbers substringFromIndex:[options length] +1];
        }
    }
    NSArray* strValues = [numbers componentsSeparatedByCharactersInSet:delimiters];
    for (NSString *strValue in strValues) {
        sum += [strValue integerValue];
    }
    return sum;
}

@end
