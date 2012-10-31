#import "WebViewController.h"

@class CardListController;
@class Category;

@interface CategoryController : WebViewController

@property(nonatomic, strong) Category *category;
@property(nonatomic, strong) CardListController *cardListController;

@end