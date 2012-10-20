#import "InfoController.h"

#define INFO_ABOUT 0
#define INFO_BUY 1
#define INFO_WEBSITE 2
#define INFO_DONATE 3
#define INFO_HOW 4

@implementation InfoController {

}

- (void)viewDidLoad {
  self.navigationItem.title = @"Info";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"CardCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }

  switch(indexPath.row) {
    case INFO_ABOUT:
      cell.textLabel.text = @"About the Patterns";
      break;
    case INFO_BUY:
      cell.textLabel.text = @"Buy a Printed Deck";
      break;
    case INFO_WEBSITE:
      cell.textLabel.text = @"Go to the Website";
      break;
    case INFO_DONATE:
      cell.textLabel.text = @"Donate!";
      break;
    case INFO_HOW:
      cell.textLabel.text = @"How Do I Use Them?";
      break;
    default:
      break;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  switch(indexPath.row) {
    case INFO_ABOUT:
      [self performSegueWithIdentifier:@"about" sender:self];
      break;
    case INFO_BUY:
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:BUY_URL]];
      break;
    case INFO_WEBSITE:
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:WEBSITE_URL]];
      break;
    case INFO_DONATE:
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DONATE_URL]];
      break;
    case INFO_HOW:
      [self performSegueWithIdentifier:@"how_to_use" sender:self];
      break;
    default:
      break;
  }
}

@end