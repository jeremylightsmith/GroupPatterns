@interface CardListController : UITableViewController {
  NSMutableArray *cards;
}

@property (nonatomic, strong) NSMutableArray *cards;

//- (IBAction)reloadCards;
- (void)openCardWithName:(NSString *)name;

@end
