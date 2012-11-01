#import <MessageUI/MessageUI.h>
#import "CardController.h"
#import "Card.h"
#import "CardListController.h"
#import "CategoryController.h"
#import "Category.h"

@interface CardController ()

@end

@implementation CardController {
@private
  CardListController *_cardListController;
}


@synthesize card;
@synthesize cardListController = _cardListController;


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
                                                  "body { font-family: 'Avenir-Book'; padding: 10px; }"
                                                  "img { width: 290px; }"
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
                                                  ".category h3, .related h3 { font-size: 1em; margin: 10px 0 0; }"
                                                  ".category a, .related a { display: block; }"
                                                  "</style>"
                                                  "</head>"
                                                  "<body>"
                                                  "<img src='%@'></img>"
                                                  "<div class='heart'>%@</div>"
                                                  "<div class='category'><h3>Category</h3><a href='/categories/%@'>%@</a></div>"
                                                  "<div class='related'><h3>Related</h3>%@</div>"
                                                  "</body></html>",
                                              [card imageName],
                                              card.heart,
                                              card.category, card.category,
                                              [self cardLinksHtml:card.related]
  ];
  return html;
}

- (NSString *)cardLinksHtml:(NSArray *)names {
  return [[names map:^(NSString *name) {
    return [NSString stringWithFormat:@"<a href='/cards/%@'>%@</a>", name, name];
  }] componentsJoinedByString:@""];
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  NSString *name = [[request URL] lastPathComponent];
  NSString *type = [[[request URL] pathComponents] objectAtIndex:1];

  if ([type isEqualToString:@"cards"]) {
    [self.navigationController popToViewController:self.cardListController animated:false];
    [self.cardListController openCardWithName:name];
    return FALSE;

  } else if ([type isEqualToString:@"categories"]) {
    CategoryController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryController"];
    controller.category = [Category findByName:[name lastPathComponent]];
    controller.cardListController = self.cardListController;
    [self.navigationController pushViewController:controller animated:true];
    return FALSE;

  } else {
    return TRUE;
  }
}

- (IBAction)shareThis {
  NSString *subject = [NSString stringWithFormat:@"Check out %@", self.card.name];
  NSString *body = [NSString stringWithFormat:@"\n\nI wanted to tell you about the pattern, %@.\n"
                                                  "You can read more about it at <a href='%@'>%@</a>.", 
          self.card.name, self.card.url, self.card.url];


  MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
  controller.mailComposeDelegate = self;
  [controller setSubject:subject];
  [controller setMessageBody:body isHTML:true];
  [controller addAttachmentData:UIImagePNGRepresentation([card cardImage]) mimeType:@"image/png" fileName:card.imageName];

  if (controller) [self presentModalViewController:controller animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
  if (result == MFMailComposeResultSent) {
    NSLog(@"It's away!");
  }
  [self dismissModalViewControllerAnimated:YES];
}

@end
