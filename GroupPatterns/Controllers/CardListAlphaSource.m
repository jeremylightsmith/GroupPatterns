#import <OCTotallyLazy/OCTotallyLazy.h>
#import "CardListAlphaSource.h"
#import "Card.h"


@implementation CardListAlphaSource {

}

- (id)initWithCards:(NSMutableArray *)theCards {
  self = [super init];
  cards = ([theCards groupBy:^(Card *card) {
    return [card.name substringToIndex:1];
  }]);
  return self;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [[[[cards objectAtIndex:(NSUInteger) section] first] name] substringToIndex:1];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
  return [cards map:^(Sequence *items) {
    return [[[items first] name] substringToIndex:1];
  }];
}


@end