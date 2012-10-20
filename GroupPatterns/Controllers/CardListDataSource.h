@class Card;

@interface CardListDataSource : NSObject <UITableViewDataSource> {
  NSArray *cards;
}
- (Card *)getCard:(NSIndexPath *)indexPath;

@end