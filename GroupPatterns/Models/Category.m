#import "Category.h"
#import "NSString+Helpers.h"


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

@end