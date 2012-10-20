#import <OCTotallyLazy/OCTotallyLazy.h>
#import "CardListDataSource.h"
#import "Card.h"


@implementation CardListDataSource {

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"CardCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }

  Card *card = [self getCard:indexPath];
  cell.textLabel.text = card.name;
  cell.imageView.image = [card smallImage];

  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[cards objectAtIndex:(NSUInteger) section] asArray] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return cards.count;
}

- (Card *)getCard:(NSIndexPath *)indexPath {
  return [[[cards objectAtIndex:(NSUInteger) indexPath.section] asArray] objectAtIndex:(NSUInteger) indexPath.row];
}

@end