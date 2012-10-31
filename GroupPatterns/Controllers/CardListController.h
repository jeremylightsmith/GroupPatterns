@class CardListAlphaSource;

@interface CardListController : UITableViewController {
}

- (void)openCardWithName:(NSString *)name;
- (IBAction)sortChanged:(UISegmentedControl *)segmentedControl;
- (void)dealACard;

@end
