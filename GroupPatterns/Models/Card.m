#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import "Card.h"
#import "Category.h"
#import "NSString+Helpers.h"


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

+ (NSMutableArray *)loadCards {
  return [[self loadJsonFromFile:@"cards"] map:^(NSDictionary *json) {
    return [[Card alloc] initWithDictionary:json];
  }];
}

+ (NSMutableArray *)loadCategories:(NSArray *)cards {
  return [[self loadJsonFromFile:@"categories"] map:^(NSDictionary *json) {
    Category *category = [[Category alloc] initWithDictionary:json];
    category.cards = [[cards filter:^(Card *card) {
      return [card.category isEqualToString:category.name];
    }] asArray];

    return category;
  }];
}

+ (NSArray *)loadJsonFromFile:(NSString *)fileName {
  NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

- (NSString *)url {
  return [NSString stringWithFormat:@"http://groupworksdeck.org/patterns/%@",
          [self.name stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
}

- (UIImage *)image {
  return [UIImage imageNamed:[self imageName]];
}

- (NSString *)imageName {
  return [[self.name safeFileName] stringByAppendingPathExtension:@"jpg"];
}

- (UIImage *)smallImage {
  NSString *imageName = [[[self.name safeFileName] stringByAppendingString:@"_small"] stringByAppendingPathExtension:@"jpg"];
  return [UIImage imageNamed:imageName];
}
@end
