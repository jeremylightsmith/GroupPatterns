#import "NSString+Helpers.h"


@implementation NSString (Helpers)

- (NSString *)safeFileName {
  return [[[self lowercaseString]
      stringByReplacingOccurrencesOfString:@" " withString:@"_"]
      stringByReplacingOccurrencesOfString:@"&" withString:@"_"];

}

@end