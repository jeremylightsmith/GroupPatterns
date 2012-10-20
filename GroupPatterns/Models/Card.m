#import "Card.h"


@implementation Card

@synthesize name, heart, pic, category, related;

- (id)initWithDictionary:(NSDictionary *)json {
  self = [self initWithName:[json valueForKey:@"name"]
                      heart:[json valueForKey:@"heart"]
                        pic:[json valueForKey:@"pic"]
                   category:[json valueForKey:@"category"]
                    related:[json valueForKey:@"related"]];
  return self;
}

- (id)initWithName:(NSString *)aName 
             heart:(NSString *)aHeart
               pic:(NSString *)aPic
          category:(NSString *)aCategory 
           related:(NSArray *)theRelated {
  self = [super init];
  self.name = aName;
  self.heart = aHeart;
  self.pic = aPic;
  self.category = aCategory;
  self.related = theRelated;
  return self;
}

- (UIImage *)image {
  return [UIImage imageNamed:[self imageName]];
}

- (NSString *)imageName {
  return [[self simpleName] stringByAppendingPathExtension:@"jpg"];
}

- (NSString *)simpleName {
  return [[name lowercaseString]
      stringByReplacingOccurrencesOfString:@" " withString:@"_"];
}

- (UIImage *)smallImage {
  NSString *imageName = [[[self simpleName] stringByAppendingString:@"_small"] stringByAppendingPathExtension:@"jpg"];
  return [UIImage imageNamed:imageName];
}
@end
