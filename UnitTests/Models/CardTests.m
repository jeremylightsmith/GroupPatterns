#import "Card.h"

@interface CardTests : SenTestCase
@end

@implementation CardTests {
}

- (void)testShouldLoadCards {
  NSArray *cards = [Card loadCards];

  assertThat(num(cards.count), is(num(91)));
  Card *card = [cards objectAtIndex:0];
  assertThat(card.name, is(@"Aesthetics of Space"));
}


@end