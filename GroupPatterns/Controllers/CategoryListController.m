#import "CategoryListController.h"
#import "CategoryController.h"
#import "Category.h"
#import "CardListController.h"


@implementation CategoryListController {
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Category System";
  [self loadHTMLString:[self categoryHtml]];
}

- (NSString *)categoryHtml {
  NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html>\n"
      "<html>\n"
      "<head>\n"
      "    <title>Categories</title>\n"
      "    <style type='text/css'>\n"
      "        body { font-family: 'Avenir-Book'; padding: 0 10px; }\n"
      "        p, li { margin: 1em 0; }\n"
                                                  ".category { margin-left: 40px; margin-top: 20px; }"
                                                  ".category img { margin-left: -40px; float: left; width: 35px; }"
                                                  ".category .category-name { font-size: 1.2em; }"
      "    </style>\n"
      "\n"
      "</head>\n"
      "<body>\n"
      "\n"
      "<p>\n"
      "    Following is a list of the categories (each with the corresponding icon) and a brief description of each category.\n"
      "    Click the category to see a list of its cards in alphabetical order. \n"
      "</p>\n"
      "\n"
      "<div class=\"categories\">%@</div>\n"
      "\n"
      "</body>\n"
      "</html>",
      [self categoryLinksHtml]
  ];
  return html;
}

- (NSString *)categoryLinksHtml {
  return [[[Category all] map:^(Category *category) {
    return [NSString stringWithFormat:@"<div class='category'><a class='category-name' href='/categories/%@'><img src='%@'/> %@</a> <div class='description'>%@</div></div>", category.name, [category imageName], category.name, category.desc];
  }] componentsJoinedByString:@""];
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  NSString *name = [[request URL] lastPathComponent];
  NSString *type = [[[request URL] pathComponents] objectAtIndex:1];

  if ([type isEqualToString:@"categories"]) {
    CategoryController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryController"];
    controller.category = [Category findByName:[name lastPathComponent]];
    [self.navigationController pushViewController:controller animated:true];
    return FALSE;

  } else {
    return TRUE;
  }
}

@end