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
}


@synthesize cards;
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

- (void)loadCardsFromDefaultFile {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSArray *cardJsons = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

  self.cards = [self jsonToCards:cardJsons];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.navigationItem.title = @"Patterns";
  self.clearsSelectionOnViewWillAppear = NO;

  self.cards = [NSMutableArray array];
  if ([cards count] == 0) {
    [self loadCardsFromDefaultFile];
  }

  [self sortByAlpha];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"show_card"]) {
    CardController *controller = [segue destinationViewController];
    controller.card = self.selectedCard;
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
  NSLog(@"sort by alpha");
  self.sort = @"alpha";
  self.dataSource = [[CardListAlphaSource alloc] initWithCards:cards];
  self.tableView.dataSource = self.dataSource;
  [self.tableView reloadData];
}

- (void)sortByCategory {
  NSLog(@"sort by cat");
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

@end
