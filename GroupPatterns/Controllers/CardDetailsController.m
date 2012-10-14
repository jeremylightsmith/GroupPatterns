#import "CardDetailsController.h"
#import "Card.h"

@implementation CardDetailsController

@synthesize card;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  return self;
}

- (void)dealloc {
  self.card = nil;
  [super dealloc];
}

- (void)cardTapped {
  [self dismissModalViewControllerAnimated:true];
}

- (NSString *)cardLinksHtml {
  NSMutableArray *cardLinks = [NSMutableArray array];
  for (NSString *name in card.related) {
    [cardLinks addObject:[NSString stringWithFormat:@"<a href='%@'>%@</a>", name, name]];
  }
  return [cardLinks componentsJoinedByString:@", "];
}

- (NSString *)cardDetailHtml {
  return [NSString stringWithFormat:@"<html><head></head><body><h1>%@</h1><p><label>Category:</label><br/>%@</p><p><label>Related Patterns:</label><br/>%@</p></body></html>",
          card.name,
          card.category,
          [self cardLinksHtml]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSLog(@"card = %@, html = %@", [card description], [self cardDetailHtml]);
  [webView loadHTMLString:[self cardDetailHtml] baseURL:[NSURL URLWithString:@"http://grouppatternlanguage.org/"]];

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardTapped)];
  [webView addGestureRecognizer:tap];
  [tap release];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
