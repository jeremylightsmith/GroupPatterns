#import "Card.h"


@implementation Card

@synthesize name, heart, pic;

- (id)initWithDictionary:(NSDictionary *)json {
  self = [super init];
  return self;
}

- (id)initWithName:(NSString *)aName heart:(NSString *)aHeart pic:(NSString *)aPic {
  self = [super init];
  self.name = aName;
  self.heart = aHeart;
  self.pic = aPic;
  return self;
}

- (void)dealloc {
  self.name = nil;
  self.heart = nil;
  self.pic = nil;
  [super dealloc];
}

@end
