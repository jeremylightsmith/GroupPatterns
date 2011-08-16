#import "CardListController.h"
#import "Card.h"
#import "CardController.h"
#import "RestClient.h"

@implementation CardListController

@synthesize cards;

- (NSString *)filePath {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
  return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"cards.plist"];
}

- (NSMutableArray *)jsonToCards:(NSArray *)cardsJson {
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:[cardsJson count]];
  for (NSDictionary *cardJson in cardsJson) {
    Card *card = [[Card alloc] initWithDictionary:cardJson];
    [array addObject:card];
    [card release];
  }
  return array;
}

- (void)loadCardsFromFile {
  NSMutableDictionary* properties = [NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
  if (properties) { 
    self.cards = [self jsonToCards:[properties objectForKey:@"cards"]];
  }
}

- (void)writeCardsToFile:(NSArray *)cardJsons {
  NSMutableDictionary* properties = [NSMutableDictionary dictionary];
  [properties setObject:cardJsons forKey:@"cards"];
  [properties writeToFile:[self filePath] atomically: YES];
}


- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  
  return self;
}

- (void)dealloc {
  self.cards = nil;
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.title = @"Patterns";
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.cards = [NSMutableArray array];
  [self loadCardsFromFile];
  if ([cards count] == 0) {
    [self reloadCards];
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
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  Card *card = [cards objectAtIndex:indexPath.row];
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

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  CardController *controller = [[CardController alloc] initWithNibName:@"CardController" bundle:nil];
  controller.card = [cards objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:controller animated:true];
  [controller release];
}

- (void)showAlert:(NSString *)message {  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                  message:message
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
  [alert show];
  [alert release];
}

- (void)reloadCards {
  RestClient *client = [[RestClient alloc] init];
  [client get:@"http://cardapp.heroku.com/group_patterns.json"
         wait:true
      success:[[^(NSArray *cardJsons) { 
    
    self.cards = [self jsonToCards:cardJsons];

    [self writeCardsToFile:cardJsons];
    [self.tableView reloadData];

  } copy] autorelease]
        error:[[^(NSError *error) { 
          [self showAlert:@"Couldn't load cards, are you connected to the internet?"];
        } copy] autorelease]];
  [client release];
}

@end
