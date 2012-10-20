#import "AboutController.h"


@implementation AboutController {

}

- (void)viewDidLoad {
  self.navigationItem.title = @"About the Patterns";

  [self loadPage:@"about.html"];
}

@end