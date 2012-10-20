@class CardListAlphaSource;

@interface CardListController : UITableViewController {
}

@property(nonatomic, strong) NSMutableArray *cards;

@property(nonatomic, strong) NSMutableArray *categories;

- (void)openCardWithName:(NSString *)name;
- (IBAction)sortChanged:(UISegmentedControl *)segmentedControl;
- (void)dealACard;

@end
