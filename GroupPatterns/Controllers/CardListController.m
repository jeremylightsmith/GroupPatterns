#import "CardListController.h"
#import "Card.h"
#import "CardController.h"
#import "CardListAlphaSource.h"
#import "CardListCategorySource.h"

@interface CardListController ()
@property(nonatomic, strong) Card *selectedCard;
@property(nonatomic, copy) NSString *sort;
@property(nonatomic, strong) CardListDataSource *dataSource;


@end

@implementation CardListController {
@private
  Card *_selectedCard;
  NSString *_sort;
  CardListDataSource *_dataSource;
  NSMutableArray *cards;
}

@synthesize selectedCard = _selectedCard;
@synthesize sort = _sort;
@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
  [super viewDidLoad];
  cards = [Card all];

  self.navigationItem.title = @"Patterns";
  self.clearsSelectionOnViewWillAppear = NO;

  [self sortByAlpha];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"show_card"]) {
    CardController *controller = [segue destinationViewController];
    controller.card = self.selectedCard;
    controller.cardListController = self;
  }
}

- (void)openCard:(Card *)card {
  self.selectedCard = card;
  [self performSegueWithIdentifier:@"show_card" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self openCard:[self.dataSource getCard:indexPath]];
}

- (void)openCardWithName:(NSString *)name {
  [self openCard:[Card findByName:name]];
}

- (void)sortByAlpha {
  self.sort = @"alpha";
  self.dataSource = [[CardListAlphaSource alloc] initWithCards:cards];
  self.tableView.dataSource = self.dataSource;
  [self.tableView reloadData];
}

- (void)sortByCategory {
  self.sort = @"category";
  self.dataSource = [[CardListCategorySource alloc] initWithCards:cards];
  self.tableView.dataSource = self.dataSource;
  [self.tableView reloadData];
}

- (void)sortChanged:(UISegmentedControl *)segmentedControl {
  switch ([segmentedControl selectedSegmentIndex]) {
    case 0:
      [self sortByAlpha];
      break;
    case 1:
      [self sortByCategory];
      break;
    default:
      break;
  }
}

- (void)dealACard {
  Card *card = [[Card all] objectAtIndex:arc4random() % [Card all].count];
  [self openCard:card];
}

@end
