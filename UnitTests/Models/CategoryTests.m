#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import "Category.h"

@interface CategoryTests : SenTestCase
@end

@implementation CategoryTests {
}

- (void)testShouldKnowImageName {
  Category *category = [[Category alloc] init];
  category.name = @"Some Thing";

  assertThat([category imageName], is(@"some_thing.png"));
}


@end