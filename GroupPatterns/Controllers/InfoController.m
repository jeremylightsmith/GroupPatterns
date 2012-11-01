#import "InfoController.h"
#import "WebViewController.h"

#define INFO_ABOUT 0
#define INFO_BUY 1
#define INFO_DONATE 2
#define INFO_CATEGORIES 3
#define INFO_RELATED_PATTERNS 4
#define INFO_ACTIVITIES 5
#define INFO_WEBSITE 6
#define INFO_GET_INVOLVED 7
#define INFO_ACKNOWLEDGEMENTS 8
#define INFO_WHO_ARE_THESE_PEOPLE 9

@interface InfoController ()
@property(nonatomic, copy) NSString *pageToOpen;

@end

@implementation InfoController {

@private
  NSString *_pageToOpen;
}
@synthesize pageToOpen = _pageToOpen;


- (void)viewDidLoad {
  self.navigationItem.title = @"Info";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return INFO_ACKNOWLEDGEMENTS + 1;
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
    case INFO_CATEGORIES:
      cell.textLabel.text = @"Category System";
      break;
    case INFO_BUY:
      cell.textLabel.text = @"Buy Printed Deck";
      break;
    case INFO_DONATE:
      cell.textLabel.text = @"Donate!";
      break;
    case INFO_WEBSITE:
      cell.textLabel.text = @"Go to Website";
      break;
    case INFO_GET_INVOLVED:
      cell.textLabel.text = @"Get Involved";
      break;
    case INFO_ACTIVITIES:
      cell.textLabel.text = @"Activities";
      break;
    case INFO_RELATED_PATTERNS:
      cell.textLabel.text = @"Related Patterns";
      break;
    case INFO_ACKNOWLEDGEMENTS:
      cell.textLabel.text = @"Acknowledgements";
      break;
    case INFO_WHO_ARE_THESE_PEOPLE:
      cell.textLabel.text = @"Who Are These People?";
      break;
    default:
      break;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  switch(indexPath.row) {
    case INFO_ABOUT:
      [self open:@"about.html"];
      break;
    case INFO_CATEGORIES:
      [self openCategoryList];
      break;
    case INFO_BUY:
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:BUY_URL]];
      break;
    case INFO_DONATE:
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DONATE_URL]];
      break;
    case INFO_WEBSITE:
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:WEBSITE_URL]];
      break;
    case INFO_GET_INVOLVED:
      [self open:@"http://groupworksdeck.org/participation"];
      break;
    case INFO_ACTIVITIES:
      [self open:@"http://groupworksdeck.org/activities"];
      break;
    case INFO_RELATED_PATTERNS:
      [self open:@"related_patterns.html"];
      break;
    case INFO_ACKNOWLEDGEMENTS:
      [self open:@"acknowledgements.html"];
      break;
    case INFO_WHO_ARE_THESE_PEOPLE:
      [self open:@"who_are_these_people.html"];
      break;
    default:
      break;
  }
}

- (void)open:(NSString *)url {
  self.pageToOpen = url;
  [self performSegueWithIdentifier:@"WebViewController" sender:nil];
}

- (void)openCategoryList {
  [self performSegueWithIdentifier:@"CategoryListController" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"WebViewController"]) {
    WebViewController *controller = segue.destinationViewController;
    [controller loadPage:self.pageToOpen];
  }
}

@end