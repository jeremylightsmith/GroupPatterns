#import "CategoryController.h"
#import "CardListController.h"

@implementation CategoryController {

@private
  NSString *_categoryName;
  NSMutableArray *_cards;
  CardListController *_cardListController;
}

@synthesize categoryName = _categoryName;
@synthesize cards = _cards;
@synthesize cardListController = _cardListController;


- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = self.categoryName;
  [self loadHTMLString:[self categoryHtml]];
}

- (NSString *)categoryHtml {
  NSString *html = [NSString stringWithFormat:@"<html>"
                                                  "<head>"
                                                  "<style type='text/css'>"
                                                  "body {"
                                                  "}"
                                                  "img {"
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
                                                  "<img src='%@.jpg'></img>"
                                                  "<div class='description'>%@</div>"
                                                  "<div class='related'><label>related:</label>%@</div>"
                                                  "</body></html>",
                                              self.categoryName,
                                              @"description",
                                              [self cardLinksHtml:[NSMutableArray array]]
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

  } else {
    return TRUE;
  }
}

@end