#import "Category.h"
#import "NSString+Helpers.h"
#import "Card.h"


NSMutableArray *allCategories;

@interface Category ()

@end

@implementation Category {

@private
  NSString *_name;
  NSArray *_cards;
  NSString *_desc;
}
@synthesize name = _name;
@synthesize desc = _desc;
@synthesize cards = _cards;


- (id)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  self.name = [dictionary objectForKey:@"name"];
  self.desc = [dictionary objectForKey:@"description"];
  return self;
}

- (NSString *)imageName {
  return [[self.name safeFileName] stringByAppendingPathExtension:@"png"];
}

+ (NSMutableArray *) all {
  if (!allCategories) {
    allCategories = [Card loadCategories:[Card all]];
  }
  return allCategories;
}

+ (Category *)findByName:(NSString *)name {
  return [[[self all] find:^(Category *c) {
    return [c.name isEqualToString:name];
  }] get];
}


@end