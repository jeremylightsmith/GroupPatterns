#import "Card.h"


@implementation Card

@synthesize name, heart, pic;

- (id)initWithDictionary:(NSDictionary *)json {
  self = [self initWithName:[json valueForKey:@"name"]
                      heart:[json valueForKey:@"heart"]
                        pic:[json valueForKey:@"pic"]];
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

- (NSDictionary *)toDictionary {
  return [NSDictionary dictionaryWithObjectsAndKeys:
                              name, @"name",
                              heart, @"heart", 
                              pic, @"pic", nil];
}

@end
