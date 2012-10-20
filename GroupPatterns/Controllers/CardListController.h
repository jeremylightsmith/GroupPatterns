@class CardListAlphaSource;

@interface CardListController : UITableViewController {
}

@property(nonatomic, strong) NSMutableArray *cards;

- (void)openCardWithName:(NSString *)name;
- (IBAction)sortChanged:(UISegmentedControl *)segmentedControl;
- (void)dealACard;

@end
