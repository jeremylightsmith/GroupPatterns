#import "CardController.h"
#import "Card.h"
#import "CardListController.h"
#import "CategoryController.h"

@interface CardController ()
@property(nonatomic, copy) NSString *selectedCategoryName;

@end

@implementation CardController {
@private
  CardListController *_cardListController;
  NSString *_selectedCategoryName;
}


@synthesize card;
@synthesize cardListController = _cardListController;
@synthesize selectedCategoryName = _selectedCategoryName;


- (void)makeTitleFit {
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
  [self makeTitleFit];
  [self loadHTMLString:[self cardHtml]];
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
                                                  "<div class='category'><label>category:</label><a href='/categories/%@'>%@</a></div>"
                                                  "<div class='related'><label>related:</label>%@</div>"
                                                  "</body></html>",
                                              [card imageName],
                                              card.heart,
                                              card.category, card.category,
                                              [self cardLinksHtml:card.related]
  ];
  return html;

}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  NSString *name = [[request URL] lastPathComponent];
  NSString *type = [[[request URL] pathComponents] objectAtIndex:1];

  if ([type isEqualToString:@"cards"]) {
    [self.navigationController popToViewController:self.cardListController animated:false];
    [self.cardListController openCardWithName:name];
    return FALSE;

  } else if ([type isEqualToString:@"categories"]) {
    self.selectedCategoryName = [name lastPathComponent];
    [self performSegueWithIdentifier:@"category" sender:self];
    return FALSE;

  } else {
    return TRUE;
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"category"]) {
    CategoryController *controller = segue.destinationViewController;
    controller.categoryName = self.selectedCategoryName;
    controller.cardListController = self.cardListController;
    controller.cards = self.cardListController.cards;
  }
}


@end
