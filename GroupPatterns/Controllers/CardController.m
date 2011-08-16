#import "CardController.h"
#import "Card.h"
#import "AsyncImageView.h"

@implementation CardController

@synthesize card;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  return self;
}

- (void)dealloc {
  self.card = nil;
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = card.name;
  titleLabel.text = card.name;
  heartLabel.text = card.heart;
  [imageView loadImageFromURL:[NSURL URLWithString:card.pic]];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  self.card = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
