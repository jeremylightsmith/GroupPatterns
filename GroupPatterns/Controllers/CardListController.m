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

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  
  return self;
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
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.cards = [NSMutableArray array];
//  [self loadCardsFromFile];
  if ([cards count] == 0) {
    [self loadCardsFromDefaultFile];
  }
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
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
    
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


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
