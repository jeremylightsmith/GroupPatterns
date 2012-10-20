#import "WebViewController.h"

@class CardListController;

@interface CategoryController : WebViewController

@property(nonatomic, copy) NSString *categoryName;
@property(nonatomic, strong) NSMutableArray *cards;
@property(nonatomic, strong) CardListController *cardListController;

@end