@class CardListAlphaSource;

@interface CardListController : UITableViewController {
  NSMutableArray *cards;
}

@property (nonatomic, strong) NSMutableArray *cards;

- (void)openCardWithName:(NSString *)name;

- (IBAction)sortChanged:(UISegmentedControl *)segmentedControl;


@end
