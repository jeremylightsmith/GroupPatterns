@class Card;

@interface CardDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
  Card *card;
  IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) Card *card;

@end
