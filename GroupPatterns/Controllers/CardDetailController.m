#import "CardDetailController.h"
#import "Card.h"
#import "CardListController.h"

@implementation CardDetailController

@synthesize card;


- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Details";
}

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
  return 2;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return @"Category";
  } else {
    return @"Related Patterns";
  }
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 1;
  } else {
    return [card.related count];
  }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }

  if (indexPath.section == 0) {
    cell.textLabel.text = card.category;
  } else {
    cell.textLabel.text = [card.related objectAtIndex:(NSUInteger) indexPath.row];
  }
  
  return cell;
}

- (NSIndexPath *)tableView:(UITableView *)aTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return nil;
    
  } else {
    NSString *name = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    UINavigationController *nav = self.navigationController;
    [nav popViewControllerAnimated:false];
    [nav popViewControllerAnimated:false];
    CardListController *controller = (CardListController *)[nav topViewController];
    [controller openCardWithName:name];
    return indexPath;
  }
}

@end
