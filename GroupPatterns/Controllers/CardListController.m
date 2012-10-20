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
  NSMutableArray *_cards;
}

@synthesize cards = _cards;
@synthesize selectedCard = _selectedCard;
@synthesize sort = _sort;
@synthesize dataSource = _dataSource;


- (NSMutableArray *)jsonToCards:(NSArray *)cardsJson {
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:[cardsJson count]];
  for (NSDictionary *cardJson in cardsJson) {
    Card *card = [[Card alloc] initWithDictionary:cardJson];
    [array addObject:card];
  }
  return array;
}

- (NSMutableArray *)loadCards {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSArray *cardJsons = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

  return [self jsonToCards:cardJsons];
}

- (NSMutableArray *)cards {
  if (!_cards) {
    self.cards = [self loadCards];
  }
  return _cards;
}

- (NSMutableArray *)loadCategoriesFromDefaultFile {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSArray *cardJsons = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

  return [self jsonToCards:cardJsons];
}

- (NSMutableArray *)categories {
  if (!_cards) {
//    self.cards = [self loadCategories];
  }
  return _cards;
}

- (void)viewDidLoad {
  [super viewDidLoad];

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

- (Card *)findCardWithName:(NSString *)name {
  for (Card *card in self.cards) {
    if ([name isEqualToString:card.name]) return card;
  }
  return nil;
}

- (void)openCardWithName:(NSString *)name {
  [self openCard:[self findCardWithName:name]];
}

- (void)sortByAlpha {
  self.sort = @"alpha";
  self.dataSource = [[CardListAlphaSource alloc] initWithCards:self.cards];
  self.tableView.dataSource = self.dataSource;
  [self.tableView reloadData];
}

- (void)sortByCategory {
  self.sort = @"category";
  self.dataSource = [[CardListCategorySource alloc] initWithCards:self.cards];
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
  Card *card = [self.cards objectAtIndex:arc4random() % self.cards.count];
  [self openCard:card];
}

@end
