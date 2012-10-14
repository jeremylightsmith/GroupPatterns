#import "CardController.h"
#import "Card.h"
#import "AsyncImageView.h"
#import "CardDetailController.h"

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

- (void)setNavigationTitle {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont boldSystemFontOfSize:16.0];
  label.textColor = [UIColor whiteColor];
  label.text = self.navigationItem.title;
  label.numberOfLines = 1;
  label.adjustsFontSizeToFitWidth = true;
  [label sizeToFit];
  label.center = self.navigationItem.titleView.center;
  self.navigationItem.titleView = label;
  [label release];
}

- (void)cardTapped {
  CardDetailController *controller = [[CardDetailController alloc] initWithNibName:@"CardDetailController" 
                                                                              bundle:nil];
  controller.card = card;
  [self.navigationController pushViewController:controller animated:true];
  [controller release];
//  controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//  [self presentModalViewController:controller animated:true];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = card.name;

  [self setNavigationTitle];
  
  heartLabel.text = card.heart;
  [heartLabel sizeToFit];
  
  [imageView loadImageFromURL:[NSURL URLWithString:card.pic]];
  
  scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, heartLabel.frame.origin.y + heartLabel.frame.size.height);
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardTapped)];
  [self.view addGestureRecognizer:tap];
  [tap release];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  self.card = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
