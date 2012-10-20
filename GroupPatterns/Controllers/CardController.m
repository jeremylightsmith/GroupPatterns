#import "CardController.h"
#import "Card.h"
#import "CardListController.h"

@implementation CardController

@synthesize card;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  return self;
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
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = card.name;

  [self setNavigationTitle];

  NSString *path = [[NSBundle mainBundle] bundlePath];
  NSURL *baseURL = [NSURL fileURLWithPath:path];
  [webView loadHTMLString:[self cardHtml] baseURL:baseURL];
}

- (NSString *)cardLinksHtml {
  NSMutableArray *cardLinks = [NSMutableArray array];
  for (NSString *name in card.related) {
    [cardLinks addObject:[NSString stringWithFormat:@"<a href='%@'>%@</a>", name, name]];
  }
  return [cardLinks componentsJoinedByString:@", "];
}


- (NSString *)cardHtml {
  NSString *html = [NSString stringWithFormat:@"<html>"
                                                  "<head>"
                                                  "<style type='text/css'>"
                                                  "body {"
                                                  "}"
                                                  "img {"
                                                  "  width: 305px;"
                                                  "}"
                                                  "label {"
                                                  "  font-weight: bold;"
                                                  "  padding-right: 10px;"
                                                  "}"
                                                  ".heart, .category, .related {"
                                                  "  margin: 10px 0;"
                                                  "}"
                                                  ".heart, .category, .related {"
                                                  "  font-size: 1.1em"
                                                  "}"
                                                  ".category a, .related a {"
                                                  "}"
                                                  "</style>"
                                                  "</head>"
                                                  "<body>"
                                                  "<img src='%@'></img>"
                                                  "<div class='heart'>%@</div>"
                                                  "<div class='category'><label>category:</label>%@</div>"
                                                  "<div class='related'><label>related:</label>%@</div>"
                                                  "</body></html>",
                                                    [card imageName],
                                                    card.heart,
                                                    card.category,
                                                    [self cardLinksHtml]
                                              ];
  return html;

}

- (void)viewDidUnload {
  [super viewDidUnload];
  self.card = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  NSString *name = [[request URL] lastPathComponent];
  if ([name isEqualToString:@"GroupPatterns.app"]) return TRUE;

  UINavigationController *nav = self.navigationController;
  [nav popViewControllerAnimated:false];
  CardListController *controller = (CardListController *)[nav topViewController];
  [controller openCardWithName:name];
  return FALSE;

}

@end
