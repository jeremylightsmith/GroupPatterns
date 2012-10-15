#import "CardListController.h"
#import "Card.h"
#import "CardController.h"

@implementation CardListController

@synthesize cards;

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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [cards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"CardCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  Card *card = [cards objectAtIndex:(NSUInteger) indexPath.row];
  cell.textLabel.text = card.name;
  cell.imageView.image = [card image];

  return cell;
}

- (void)openCard:(Card *)card {
  CardController *controller = [[CardController alloc] initWithNibName:@"CardController" bundle:nil];
  controller.card = card;
  [self.navigationController pushViewController:controller animated:true];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self openCard:[cards objectAtIndex:(NSUInteger) indexPath.row]];
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

@end
