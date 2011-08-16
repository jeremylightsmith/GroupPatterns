@interface CardListController : UITableViewController {
  NSMutableArray *cards;
}

@property (nonatomic, retain) NSMutableArray *cards;

- (IBAction)reloadCards;

@end
