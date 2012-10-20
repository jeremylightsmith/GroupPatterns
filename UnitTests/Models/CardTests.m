#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import "Card.h"
#import "Category.h"

@interface CardTests : SenTestCase
@end

@implementation CardTests {
}

- (void)testShouldLoadCards {
  NSArray *cards = [Card loadCards];

  assertThat(num(cards.count), is(num(91)));

  Card *card = [cards objectAtIndex:0];
  assertThat(card.name, is(@"Aesthetics of Space"));
  assertThat(card.category, is(@"Context"));
  assertThat(card.related, is(array(@"Circle", @"Gaia", @"Hosting", @"Power of Constraints", @"Power of Place", @"Preparedness", @"Nooks in Space and Time", nil)));
}

- (void)testShouldLoadCategories {
  NSArray *cards = [Card loadCards];
  NSMutableArray *categories = [Card loadCategories:cards];

  assertThat(num(categories.count), is(num(9)));

  Card *card = [cards objectAtIndex:0];
  Category *category = [categories objectAtIndex:0];

  assertThat(category.name, is(@"Context"));
  assertThat(category.cards, hasItem(card));
}

- (void)testShouldKnowImageName {
  Card *card = [[Card alloc] init];
  card.name = @"Some Thing";

  assertThat([card imageName], is(@"some_thing.jpg"));
}

@end