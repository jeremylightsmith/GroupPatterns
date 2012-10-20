#import <OCTotallyLazy/OCTotallyLazy.h>
#import "Card.h"
#import "CardListCategorySource.h"

@implementation CardListCategorySource {

}

- (id)initWithCards:(NSMutableArray *)theCards {
  self = [super init];
  cards = ([theCards groupBy:^(Card *card) {
    return card.category;
  }]);
  return self;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [[[cards objectAtIndex:(NSUInteger) section] first] category];
}

@end