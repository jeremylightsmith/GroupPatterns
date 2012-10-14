@class Card;

@interface CardDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
  Card *card;
  IBOutlet UITableView *tableView;
}

@property (nonatomic, strong) Card *card;

@end
